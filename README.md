# 🤖 web3-mkt-agents

> Modular AI marketing system for Web3 projects, built on OpenClaw.
> Fork → fill RAG → deploy. Start with 4 agents, scale to 9.

**English** | [中文文档](README.zh.md)

---

## What It Is

A framework of specialized AI agents that handle Web3 marketing and operations. Each agent owns a specific function, uses the cheapest model that gets the job done, and coordinates through a PM Agent orchestrator.

**v0.1.0 ships with 9 agents:**

| Agent | What It Does | Model | Est. Cost/mo |
|-------|-------------|-------|-------------|
| 🧠 PM | Routes tasks, monitors all agents, weekly reports | Claude Sonnet 4.6 | $9–19 |
| 📣 Social | Twitter/X, LinkedIn, memes, trend monitoring | MiniMax M2.5 | $1–2 |
| ✍️ Content | Blog posts, video scripts, design briefs | Claude Sonnet 4.6 | $6–12 |
| 📊 Data | Token price, competitor intel, SEO, analytics | GPT-4.1 Nano | $2–3 |
| 🤝 BD | Prospect research, cold email drafting, proposals | GPT-4.1 | $4–7 |
| 💬 Community | Discord/TG sentiment, FAQ replies, crisis drafts | GPT-4o-mini | $2–4 |
| 🌐 Eco | Event announcements, ecosystem prospecting | MiniMax M2.5 | $1–3 |
| 💰 Finance | Invoice logging, budget tracking, contract alerts | Claude Sonnet 4.6 | $3–6 |
| 🛡️ Security | Impersonation scans, phishing detection, API audits | Gemini 2.5 Flash Lite | $1–2 |
| | | **Total** | **~$29–58/mo** |

vs. running everything on Claude Opus: ~$400+/mo

---

## Install

### Option A — Paste URL to your OpenClaw agent (easiest)
In any OpenClaw chat, send:
```
Install this skill: https://github.com/NanRen01/mktagent3
```
OpenClaw downloads and installs all agents automatically.

### Option B — Install individual agents only
```
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/pm
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/social
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/content
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/data
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/bd
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/community
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/eco
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/finance
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/security
```

### Option C — Clone and self-host on VPS
```bash
git clone https://github.com/NanRen01/mktagent3.git
cd mktagent3
bash scripts/deploy.sh
```

**To pull updates later:**
```bash
bash scripts/update.sh
```

---

## Setup Dashboard

The repo includes a local setup dashboard (`dashboard/index.html`) for configuring all API tokens and RAG files without touching the command line.

### Opening locally (no server needed)
Double-click `dashboard/index.html` — opens in any browser. No install required.

### Dashboard features

| Tab | What you can do |
|-----|----------------|
| 📋 Status | Setup progress, missing token warnings, deploy commands |
| 🤖 Agents | Enable/disable agents, see live cost estimate |
| 🔑 Model APIs | Fill Anthropic, OpenAI, MiniMax, Gemini keys |
| 🔌 Integrations | Slack, Telegram, Notion, Twitter, Discord, and more |
| 📝 RAG Editor | Edit all 19 RAG files, see unfilled placeholders, save to VPS |
| 📤 Export | Download `.env` file ready to place on VPS |

### Accessing Dashboard remotely via VPS

**Step 1 — Start the server on your VPS:**
```bash
cd ~/mktagent3
python3 dashboard/server.py --port 8765 --token YOUR_SECRET_PASSWORD
```

**Step 2 — Open an SSH tunnel from your local machine:**
```bash
ssh -L 8765:localhost:8765 your_user@YOUR_VPS_IP
```
Keep this terminal open. The tunnel is encrypted — dashboard is never exposed to the public internet.

**Step 3 — Open in your browser:**
```
http://localhost:8765
```

**Step 4 — Connect VPS API in RAG Editor tab:**

Enter `http://localhost:8765` and your token in the RAG Editor tab, click **Connect VPS**. You can now edit RAG files and click **Save** to write directly to your VPS — no SSH file editing needed.

---

## Quick Setup

**1. Fill RAG templates** (~30 minutes)

Use the **RAG Editor tab** in the dashboard, or edit files directly in `rag-templates/`:

```bash
# Core — fill these first
nano rag-templates/brand-voice.md          # brand tone, vocabulary, forbidden words
nano rag-templates/kpi-targets.md          # weekly targets for all metrics
nano rag-templates/alert-thresholds.md     # token symbol + price alert levels
nano rag-templates/crisis-sop.md           # crisis levels and response playbook

# Per-agent
nano rag-templates/competitor-intel.md     # Data Agent
nano rag-templates/seo-keywords.md         # Data Agent
nano rag-templates/community-faq.md        # Community Agent
nano rag-templates/bd-icp.md               # BD Agent
nano rag-templates/security-impersonation-keywords.md  # Security Agent
nano rag-templates/finance-budget-plan.md  # Finance Agent

# Copy all filled files to agent workspaces:
bash scripts/copy-rag.sh
```

**2. Configure API tokens**

Open `dashboard/index.html`, fill all tokens, click **Export → Download .env**, then upload to your VPS:
```bash
scp .env your_user@YOUR_VPS_IP:~/.openclaw/.env
```

**3. Deploy**
```bash
bash scripts/deploy.sh
```

---

## How It Works

```
You
 └─▶ PM Agent  ─────────────────────────────────────────────────────────────┐
       │                                                                      │
       ├─▶ Social Agent    trending_scan / post / meme                       │
       ├─▶ Content Agent   blog / video / banner                             │
       ├─▶ Data Agent      token / competitor / analytics ──▶ feedback loop  │
       ├─▶ BD Agent        prospects / cold email / proposals                │
       ├─▶ Community Agent sentiment / FAQ / crisis_draft                    │
       ├─▶ Eco Agent       event_announce / brand_analysis                   │
       ├─▶ Finance Agent   invoice_log / budget_tracker                      │
       └─▶ Security Agent  impersonation_scan / phishing_scan ──▶ alerts ────┘
```

**3-Tier Approval:**
- 🟢 AUTO — monitoring, routing, research, internal data
- 🟡 SLACK_REVIEW — content drafts, announcements, non-urgent alerts
- 🔴 HUMAN_REQUIRED — all outbound sends, financial actions, crisis responses

**Monday Morning Sequence (automated):**
```
08:00  Data Agent     → social_analytics() + seo_report()
08:00  BD Agent       → prospect_search() + event_scout()
08:00  Security Agent → weekly digest
09:00  PM Agent       → weekly_report() (aggregates all outputs)
09:00  Content Agent  → performance_learn() (reads Data Agent analytics)
```

---

## Adding More Agents

1. `cp -r agents/_TEMPLATE agents/your-agent`
2. Fill `AGENTS.md`, `SOUL.md`, `HEARTBEAT.md`, `TOOLS.md`
3. Add `skills/your-agent/SKILL.md`
4. Register in `config/openclaw.json.template`
5. Open a PR

Full guide: [docs/ADD_AGENT.md](docs/ADD_AGENT.md)

---

## Requirements

- [OpenClaw](https://openclaw.ai) installed and running
- API keys for the models you use (see `config/openclaw.json.template`)
- Notion workspace (task management and logs)
- Slack workspace (approvals and alerts)
- Twitter/X Developer Account (Basic tier minimum)
- Python 3.8+ on VPS (for `dashboard/server.py`)

---

## Repo Structure

```
mktagent3/
├── SKILL.md                         ← Root skill pack (GitHub install entry)
├── agents/
│   ├── _TEMPLATE/                   ← Blueprint for new agents
│   ├── pm/ social/ content/ data/   ← Core 4 agents
│   ├── bd/ community/ eco/          ← Ops agents
│   └── finance/ security/           ← Support agents
│       (each dir: AGENTS.md, SOUL.md, HEARTBEAT.md, TOOLS.md, SKILL.md, memory/)
├── skills/                          ← Individual installable skills
│   └── {pm,social,content,data,bd,community,eco,finance,security}/SKILL.md
├── rag-templates/                   ← Fill with your project's data (19 files)
├── config/
│   └── openclaw.json.template       ← All keys as {{PLACEHOLDER}}
├── scripts/
│   ├── deploy.sh                    ← First-time VPS setup
│   ├── update.sh                    ← Pull latest + hot-reload
│   └── copy-rag.sh                  ← Copy filled RAG files to workspaces
├── dashboard/
│   ├── index.html                   ← Setup dashboard (open in browser)
│   └── server.py                    ← VPS server for remote RAG editing
└── docs/
    ├── ADD_AGENT.md
    └── ROADMAP.md
```

---

## License

MIT — fork it, modify it, build on it.

---

## Contributing

PRs welcome. See [docs/ADD_AGENT.md](docs/ADD_AGENT.md) for the contribution guide.
Open an issue for bugs, feature requests, or new agent proposals.
