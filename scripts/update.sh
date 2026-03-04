#!/bin/bash
# =============================================================
# web3-mkt-agents — update.sh
# Pull latest changes from GitHub and hot-reload.
# Run this every time you push updates to the repo.
# =============================================================

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENCLAW_DIR="$HOME/.openclaw"
ENV_FILE="$OPENCLAW_DIR/.env"

echo ""
echo "🔄 web3-mkt-agents — Update"
echo ""

# ── 1. Pull latest ────────────────────────────────────────────
echo "── Step 1: Pulling latest from GitHub..."
cd "$REPO_DIR"
git pull
echo "✅ $(git log -1 --format='%h %s (%cr)')"

# ── 2. Copy updated agent files ───────────────────────────────
echo ""
echo "── Step 2: Syncing agent workspace files..."

CHANGED=0
for agent in pm social content data; do
  SRC="$REPO_DIR/agents/$agent"
  DST="$OPENCLAW_DIR/workspace-$agent"
  
  for f in AGENTS.md SOUL.md HEARTBEAT.md TOOLS.md; do
    if [ -f "$SRC/$f" ]; then
      if ! diff -q "$SRC/$f" "$DST/$f" &>/dev/null 2>&1; then
        cp "$SRC/$f" "$DST/$f"
        echo "  🔄 workspace-$agent/$f (updated)"
        CHANGED=1
      fi
    fi
  done
done

if [ "$CHANGED" -eq 0 ]; then
  echo "  ✅ No agent file changes"
fi

# ── 3. Regenerate openclaw.json if template changed ──────────
echo ""
echo "── Step 3: Checking openclaw.json.template..."

TEMPLATE="$REPO_DIR/config/openclaw.json.template"
MARKER="$OPENCLAW_DIR/.openclaw_template_hash"
NEW_HASH=$(md5sum "$TEMPLATE" | cut -d' ' -f1)
OLD_HASH=$(cat "$MARKER" 2>/dev/null || echo "none")

if [ "$NEW_HASH" != "$OLD_HASH" ]; then
  echo "  🔄 Template changed — regenerating openclaw.json..."
  source "$ENV_FILE"
  
  if command -v envsubst &>/dev/null; then
    sed 's/{{/$/g; s/}}//' "$TEMPLATE" | envsubst > "$OPENCLAW_DIR/openclaw.json.tmp"
    mv "$OPENCLAW_DIR/openclaw.json.tmp" "$OPENCLAW_DIR/openclaw.json"
  else
    python3 - <<'PYEOF'
import re, os
with open(os.environ['TEMPLATE']) as f:
    content = f.read()
def replace(match):
    return os.environ.get(match.group(1), match.group(0))
result = re.sub(r'\{\{(\w+)\}\}', replace, content)
with open(os.environ['OPENCLAW_DIR'] + '/openclaw.json', 'w') as f:
    f.write(result)
PYEOF
  fi
  
  chmod 600 "$OPENCLAW_DIR/openclaw.json"
  echo "$NEW_HASH" > "$MARKER"
  echo "  ✅ openclaw.json regenerated"
  NEED_RESTART=1
else
  echo "  ✅ No config changes"
  NEED_RESTART=0
fi

# ── 4. Restart gateway if config changed ─────────────────────
echo ""
if [ "${NEED_RESTART:-0}" -eq 1 ]; then
  echo "── Step 4: Restarting gateway (config changed)..."
  pkill -f openclaw-gateway 2>/dev/null || true
  sleep 2
  nohup openclaw gateway run \
    --bind loopback \
    --port 18789 \
    --force \
    >> /tmp/openclaw-gateway.log 2>&1 &
  sleep 3
  
  if pgrep -f openclaw-gateway > /dev/null; then
    echo "  ✅ Gateway restarted"
  else
    echo "  ❌ Gateway failed — check: cat /tmp/openclaw-gateway.log"
    exit 1
  fi
else
  echo "── Step 4: Gateway restart"
  echo "  ℹ️  MD file changes take effect on next conversation — no restart needed"
  echo "  ℹ️  To force restart: pkill -f openclaw-gateway && openclaw gateway run --bind loopback --port 18789"
fi

# ── Done ──────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════════"
echo "✅ Update complete!"
echo "   Commit: $(git log -1 --format='%h — %s')"
echo "════════════════════════════════════════"
echo ""
