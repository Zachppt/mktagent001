#!/bin/bash
# =============================================================
# web3-mkt-agents — init-github.sh
# Run once to push this repo to your GitHub.
# Usage: bash scripts/init-github.sh YOUR_GITHUB_USERNAME
# =============================================================

set -e

USERNAME="$1"

if [ -z "$USERNAME" ]; then
  echo ""
  echo "Usage: bash scripts/init-github.sh YOUR_GITHUB_USERNAME"
  echo ""
  echo "Example: bash scripts/init-github.sh alice"
  exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo ""
echo "🚀 web3-mkt-agents — GitHub Init"
echo "Username: $USERNAME"
echo "Repo:     https://github.com/$USERNAME/web3-mkt-agents"
echo ""

# ── 1. Replace YOUR_USERNAME in all files ─────────────────────
echo "── Step 1: Replacing YOUR_USERNAME → $USERNAME ..."

FILES_CHANGED=$(grep -rl "YOUR_USERNAME" . --include="*.md" --include="*.json" --include="*.sh" 2>/dev/null | wc -l)

if [ "$FILES_CHANGED" -gt 0 ]; then
  grep -rl "YOUR_USERNAME" . --include="*.md" --include="*.json" --include="*.sh" | \
    xargs sed -i "s/YOUR_USERNAME/$USERNAME/g"
  echo "  ✅ Replaced in $FILES_CHANGED files"
else
  echo "  ✅ No YOUR_USERNAME placeholders found (already replaced)"
fi

# ── 2. Initialize git ─────────────────────────────────────────
echo ""
echo "── Step 2: Initializing git..."

if [ ! -d ".git" ]; then
  git init
  echo "  ✅ git init"
else
  echo "  ✅ git already initialized"
fi

git add .
git commit -m "feat: initial release v0.1.0

9 agents: PM, Social, Content, Data, BD, Community, Eco, Finance, Security
- Multi-model cost optimization (~\$31-57/mo vs \$400+ all-Claude-Opus)
- 3-tier approval system (AUTO / SLACK_REVIEW / HUMAN_REQUIRED)
- 19 RAG templates
- deploy.sh + update.sh + copy-rag.sh scripts" 2>/dev/null || \
  echo "  ℹ️  Nothing to commit (already committed)"

# ── 3. Set remote ─────────────────────────────────────────────
echo ""
echo "── Step 3: Setting remote..."

REMOTE_URL="https://github.com/$USERNAME/web3-mkt-agents.git"

if git remote get-url origin &>/dev/null; then
  git remote set-url origin "$REMOTE_URL"
  echo "  ✅ Remote updated: $REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
  echo "  ✅ Remote added: $REMOTE_URL"
fi

# ── 4. Push ───────────────────────────────────────────────────
echo ""
echo "── Step 4: Pushing to GitHub..."
echo "  (If prompted for password, use a GitHub Personal Access Token)"
echo ""

git branch -M main
git push -u origin main

# ── Done ──────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════════"
echo "✅ Pushed!"
echo ""
echo "Repo: https://github.com/$USERNAME/web3-mkt-agents"
echo ""
echo "Anyone can now install your agents with:"
echo "  Install this skill: https://github.com/$USERNAME/web3-mkt-agents"
echo "════════════════════════════════════════"
echo ""
