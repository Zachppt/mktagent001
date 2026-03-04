#!/bin/bash
# =============================================================
# web3-mkt-agents — copy-rag.sh
# Copies filled RAG templates into the correct agent workspaces.
# Run after filling rag-templates/ with your project data.
# =============================================================

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENCLAW_DIR="$HOME/.openclaw"
TEMPLATES="$REPO_DIR/rag-templates"

echo ""
echo "📋 web3-mkt-agents — Copy RAG Files"
echo ""

# ── Check templates are filled ────────────────────────────────
UNFILLED=0
for f in brand-voice.md kpi-targets.md bd-icp.md community-faq.md security-impersonation-keywords.md; do
  if grep -q "\[YOUR PROJECT NAME\]\|\[YOUR TOKEN\]\|\[YOUR_SYMBOL\]\|\[PROJECT NAME\]" "$TEMPLATES/$f" 2>/dev/null; then
    echo "  ⚠️  $f still has unfilled placeholders"
    UNFILLED=1
  fi
done

if [ "$UNFILLED" -eq 1 ]; then
  echo ""
  echo "Fill the placeholders above before copying. Edit files in:"
  echo "  $TEMPLATES/"
  echo ""
  read -p "Continue anyway? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

# ── Helper ────────────────────────────────────────────────────
copy_rag() {
  local file="$1"
  local agent="$2"
  local src="$TEMPLATES/$file"
  local dst="$OPENCLAW_DIR/workspace-$agent/rag/$file"

  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "  ✅ $file → workspace-$agent/rag/"
  else
    echo "  ⚠️  $src not found — skipped"
  fi
}

echo "Copying files..."
echo ""

# ── Core (multiple agents) ────────────────────────────────────
echo "[ Core ]"
copy_rag "brand-voice.md"        "social"
copy_rag "brand-voice.md"        "content"
copy_rag "brand-voice.md"        "eco"
copy_rag "brand-voice.md"        "community"
copy_rag "kpi-targets.md"        "pm"
copy_rag "kpi-targets.md"        "data"
copy_rag "crisis-sop.md"         "pm"
copy_rag "crisis-sop.md"         "community"

# ── Data Agent ────────────────────────────────────────────────
echo ""
echo "[ Data Agent ]"
copy_rag "competitor-intel.md"   "data"
copy_rag "alert-thresholds.md"   "data"
copy_rag "seo-keywords.md"       "data"
copy_rag "social-meme-templates.md" "social"

# ── BD Agent ─────────────────────────────────────────────────
echo ""
echo "[ BD Agent ]"
copy_rag "bd-icp.md"             "bd"
copy_rag "bd-email-templates.md" "bd"
copy_rag "bd-event-targets.md"   "bd"
copy_rag "icp.md"                "bd"
copy_rag "email-templates.md"    "bd"

# ── Community Agent ───────────────────────────────────────────
echo ""
echo "[ Community Agent ]"
copy_rag "community-faq.md"              "community"
copy_rag "faq-knowledge-base.md"         "community"
copy_rag "community-moderator-guidelines.md" "community"
copy_rag "channel-config.md"             "community"

# ── Security Agent ────────────────────────────────────────────
echo ""
echo "[ Security Agent ]"
copy_rag "security-impersonation-keywords.md" "security"
copy_rag "security-phishing-patterns.md"      "security"
copy_rag "security-trusted-ips.md"            "security"
copy_rag "monitored-accounts.md"              "security"

# ── Finance Agent ─────────────────────────────────────────────
echo ""
echo "[ Finance Agent ]"
copy_rag "finance-budget-plan.md"  "finance"
copy_rag "finance-vendor-list.md"  "finance"

# ── Eco Agent ─────────────────────────────────────────────────
echo ""
echo "[ Eco Agent ]"
copy_rag "eco-icp.md"          "eco"
copy_rag "eco-event-formats.md" "eco"
copy_rag "ecosystem-pipeline.md" "eco"
copy_rag "routing-rules.md"   "pm"
copy_rag "agent-registry.md"  "pm"
copy_rag "design-guidelines.md" "content"
copy_rag "bd-pipeline.md"     "bd"
copy_rag "content-style-guide.md" "content"

echo ""
echo "════════════════════════════════════════"
echo "✅ RAG files copied to all agent workspaces."
echo "   Changes take effect on next conversation — no gateway restart needed."
echo "════════════════════════════════════════"
echo ""

# Note: routing-rules.md and agent-registry.md are also copied
# by deploy.sh automatically. If you need to re-copy them:
# copy_rag "routing-rules.md"   "pm"
# copy_rag "agent-registry.md"  "pm"
