#!/bin/bash
# =============================================================
# web3-mkt-agents — deploy.sh
# First-time VPS setup. Run once after cloning the repo.
#
# Security:
#   - Does NOT source .env (prevents shell injection attacks)
#   - Parses .env line-by-line with strict KEY=VALUE matching
#   - Sets openclaw.json to 600, workspace dirs to 700
# =============================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENCLAW_DIR="$HOME/.openclaw"
ENV_FILE="$OPENCLAW_DIR/.env"
ALL_AGENTS=(pm social content data bd community eco finance security)

echo ""
echo "🤖  web3-mkt-agents — Deploy"
echo "    Repo:     $REPO_DIR"
echo "    OpenClaw: $OPENCLAW_DIR"
echo ""

# ── 1. Prerequisites ───────────────────────────────────────────
echo "── Step 1: Prerequisites..."

if ! command -v openclaw &>/dev/null; then
  echo "❌ OpenClaw not found.  sudo npm i -g openclaw@latest"; exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ .env not found at $ENV_FILE"
  echo ""
  echo "   Create via dashboard:"
  echo "   1. Open dashboard/index.html in browser"
  echo "   2. Fill all tokens → Export → Download .env"
  echo "   3. scp .env user@VPS:$ENV_FILE"
  echo ""
  echo "   Or manually: mkdir -p $OPENCLAW_DIR && nano $ENV_FILE"
  exit 1
fi

echo "✅ OK"

# ── 2. Workspace dirs ──────────────────────────────────────────
echo "── Step 2: Workspace directories..."
mkdir -p "$OPENCLAW_DIR" && chmod 700 "$OPENCLAW_DIR"

for agent in "${ALL_AGENTS[@]}"; do
  ws="$OPENCLAW_DIR/workspace-$agent"
  mkdir -p "$ws/rag" "$ws/memory/archive"
  chmod 700 "$ws"
  echo "    📁 workspace-$agent"
done
echo "✅ Done"

# ── 3. Copy agent files ────────────────────────────────────────
echo "── Step 3: Agent files..."
for agent in "${ALL_AGENTS[@]}"; do
  src="$REPO_DIR/agents/$agent"
  dst="$OPENCLAW_DIR/workspace-$agent"
  for f in AGENTS.md SOUL.md HEARTBEAT.md TOOLS.md SKILL.md; do
    [ -f "$src/$f" ] && cp "$src/$f" "$dst/$f"
  done
  echo "    ✅ workspace-$agent"
done

# ── 4. Parse .env safely → generate openclaw.json ─────────────
# SECURITY: We do NOT use `source .env`.
# Instead we parse line-by-line with a strict regex.
# This prevents any shell injection from malicious values in .env.
echo "── Step 4: openclaw.json..."

declare -A ENV_VARS
while IFS= read -r line || [ -n "$line" ]; do
  [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
  if [[ "$line" =~ ^([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
    k="${BASH_REMATCH[1]}"
    v="${BASH_REMATCH[2]}"
    v="${v#\"}"; v="${v%\"}"
    v="${v#\'}"; v="${v%\'}"
    ENV_VARS["$k"]="$v"
  fi
done < "$ENV_FILE"

# Build Python dict string from parsed vars (values are escaped)
PY_DICT=""
for k in "${!ENV_VARS[@]}"; do
  esc="${ENV_VARS[$k]//\\/\\\\}"
  esc="${esc//\"/\\\"}"
  PY_DICT+="    \"$k\": \"$esc\","$'\n'
done

python3 - "$REPO_DIR" "$OPENCLAW_DIR" <<PYEOF
import re, sys
repo, openclaw = sys.argv[1], sys.argv[2]
env = {
$PY_DICT
}
tpl = open(f"{repo}/config/openclaw.json.template").read()
out = re.sub(r'\{\{(\w+)\}\}', lambda m: env.get(m.group(1), m.group(0)), tpl)
open(f"{openclaw}/openclaw.json", 'w').write(out)
missing = re.findall(r'\{\{(\w+)\}\}', out)
if missing:
    print(f"  ⚠️  Unfilled: {', '.join(missing)} — add to .env")
else:
    print("  ✅ All placeholders filled")
PYEOF

chmod 600 "$OPENCLAW_DIR/openclaw.json"
echo "✅ openclaw.json (600)"

# ── 5. RAG files ───────────────────────────────────────────────
echo "── Step 5: RAG files..."
bash "$REPO_DIR/scripts/copy-rag.sh" --quiet
echo "✅ Done"

# ── 6. Gateway ─────────────────────────────────────────────────
echo "── Step 6: Gateway..."
pkill -f openclaw-gateway 2>/dev/null || true
sleep 1
nohup openclaw gateway run --bind loopback --port 18789 --force \
  > /tmp/openclaw-gateway.log 2>&1 &
sleep 3
if pgrep -f openclaw-gateway > /dev/null; then
  echo "✅ Gateway running (PID: $(pgrep -f openclaw-gateway))"
else
  echo "❌ Gateway failed — cat /tmp/openclaw-gateway.log"; exit 1
fi

echo ""
echo "════════════════════════════════"
echo "✨ Deploy complete!"
echo ""
echo "  Next:"
echo "  1. Fill RAG files: open dashboard/index.html → RAG Editor"
echo "  2. Verify: openclaw channels status --probe"
echo "  3. Test: send a message to your PM Agent Telegram bot"
echo "════════════════════════════════"
