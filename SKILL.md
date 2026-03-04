---
name: web3-mkt-agents
description: >
  Complete 9-agent Web3 marketing system built on OpenClaw. Covers every
  marketing function: social media, content, data analytics, BD outreach,
  finance tracking, ecosystem partnerships, community management, and
  security monitoring. Install the full pack or individual agents. Bring
  your own RAG files — everything else is ready to run.
version: 1.0.0
tags: [web3, marketing, multi-agent, crypto, defi, social, content, analytics, bd, security]
metadata:
  openclaw:
    requires:
      env:
        - ANTHROPIC_API_KEY
        - OPENAI_API_KEY
        - MINIMAX_API_KEY
        - GEMINI_API_KEY
---

# Web3 Marketing Agent Framework

> Complete AI marketing system for Web3 projects. 9 specialized agents,
> multi-model cost optimization, fully modular. Fork → fill RAG → deploy.

---

## Full Agent Roster

| Agent | Role | Model | Est. Cost/mo |
|-------|------|-------|-------------|
| 🧠 PM | Orchestrator, routing, weekly reports | Claude Sonnet 4.6 | $9–19 |
| 📣 Social | Twitter/X, LinkedIn, memes, trends | MiniMax M2.5 | $1.75 |
| ✍️ Content | Blog, video scripts, design briefs | Claude Sonnet 4.6 | $6–12 |
| 📊 Data | Token monitor, competitor scan, analytics | GPT-4.1 Nano | $2.80 |
| 🤝 BD | Prospect research, cold email, proposals | GPT-4.1 | $4–7 |
| 💰 Finance | Invoices, budget tracking, CPM | Claude Sonnet 4.6 | $3–5 |
| 🌐 Ecosystem | Events, brand analysis, partnerships | MiniMax M2.5 | $1.10 |
| 💬 Community | Discord/TG sentiment, FAQ, crisis | GPT-4o Mini | $1.90 |
| 🔒 Security | Impersonation, phishing, API audit | Gemini Flash-Lite | <$0.50 |
| | | **Total** | **~$30–50/mo** |

---

## Install

### Full Pack (paste to your OpenClaw agent)
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```

### Individual Agents
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/pm
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/social
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/content
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/data
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/bd
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/finance
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/eco
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/community
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/security
```

### Self-host on VPS
```bash
git clone https://github.com/YOUR_USERNAME/web3-mkt-agents
cd web3-mkt-agents
bash scripts/deploy.sh
```

---

## Setup (3 Steps)

### 1. Fill RAG Templates
All templates are in `rag-templates/`. Copy and fill the ones you need, then run:
```bash
bash scripts/copy-rag.sh
```

### 2. Apply Config
```bash
cp config/openclaw.json.template ~/.openclaw/openclaw.json
# Edit: replace all {{PLACEHOLDER}} values
```

### 3. Restart Gateway
```bash
openclaw gateway restart
```

---

## Architecture

```
You
 └─▶ PM Agent (Claude Sonnet 4.6)
       ├─▶ Social Agent       tweet / meme / trend
       ├─▶ Content Agent      blog / video / design
       ├─▶ Data Agent         token / competitor / SEO ─▶ feedback loop
       ├─▶ BD Agent           prospect / email / proposal
       ├─▶ Finance Agent      invoice / budget / CPM
       ├─▶ Ecosystem Agent    event / brand / partners
       ├─▶ Community Agent    sentiment / FAQ / crisis
       └─▶ Security Agent     impersonation / phishing / audit
```

**3-Tier Approval:**
- 🟢 AUTO — monitoring, routing, internal data
- 🟡 SLACK_REVIEW — content drafts, announcements, reports
- 🔴 HUMAN_REQUIRED — outbound sends, payments, crisis response

---

## Source
GitHub: https://github.com/YOUR_USERNAME/web3-mkt-agents
MIT License.
