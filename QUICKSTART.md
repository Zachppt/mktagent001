# ⚡ Quick Start

> Get your first agent responding in under 20 minutes.
> This guide walks you through the minimum viable setup: PM Agent + Social Agent.

---

## Before You Start

You need:
- [ ] [OpenClaw](https://openclaw.ai) installed (`npm i -g openclaw@latest`)
- [ ] An Anthropic API key ([get one here](https://console.anthropic.com))
- [ ] A MiniMax API key ([get one here](https://minimaxi.com))
- [ ] A Slack workspace with a bot token
- [ ] A Telegram bot token (create via [@BotFather](https://t.me/BotFather))

---

## Step 1 — Install the skill pack (2 minutes)

Paste this into your OpenClaw agent:
```
Install this skill: https://github.com/NanRen01/mktagent3
```

Or clone manually:
```bash
git clone https://github.com/NanRen01/mktagent3.git
cd mktagent3
```

---

## Step 2 — Open the Dashboard (1 minute)

Double-click `dashboard/index.html` in your file manager.
It opens in your browser. No server needed.

You'll see a setup checklist. Your goal: get it to **100%**.

---

## Step 3 — Fill API tokens (5 minutes)

In the Dashboard, go to **🔑 Model APIs** and fill:

| Key | Where to get it |
|-----|----------------|
| `ANTHROPIC_API_KEY` | [console.anthropic.com](https://console.anthropic.com) → API Keys |
| `OPENAI_API_KEY` | [platform.openai.com](https://platform.openai.com) → API Keys |
| `MINIMAX_API_KEY` | [minimaxi.com](https://minimaxi.com) → API Keys |
| `GEMINI_API_KEY` | [aistudio.google.com](https://aistudio.google.com) → Get API key |

Go to **🔌 Integrations** and fill at minimum:

| Key | Where to get it |
|-----|----------------|
| `SLACK_BOT_TOKEN` | api.slack.com/apps → your app → OAuth Tokens |
| `SLACK_APPROVALS_CHANNEL_ID` | Right-click your #approvals channel → Copy link → last part of URL |
| `SLACK_ALERTS_CHANNEL_ID` | Same, for your alerts channel |
| `NOTION_TOKEN` | notion.so/profile/integrations → new integration |
| `NOTION_TASK_DB_ID` | Open your Notion task DB → Share → Copy link → 32-char ID in URL |
| `TG_TOKEN_PM` | @BotFather → /newbot → copy token |
| `GATEWAY_AUTH_TOKEN` | Click **⚡ Generate Random Token** in the dashboard |

---

## Step 4 — Fill your 3 core RAG files (10 minutes)

Go to **📝 RAG Editor** in the dashboard.

### brand-voice.md
Click it in the left panel. Fill every `[placeholder]` — especially:
- Project Name and Token Symbol
- One-line description
- Tone of voice per platform
- Forbidden words

### kpi-targets.md
Set your weekly targets. Start conservative — you can raise them later.
- Twitter impressions, engagement rate, follower growth
- Blog posts per week
- Your CoinGecko token ID

### alert-thresholds.md
Just two things:
- Your CoinGecko Token ID (find it at coingecko.com/en/coins/YOUR-TOKEN)
- Your token symbol

Click **💾 Save** after each file.

---

## Step 5 — Export .env and deploy (2 minutes)

In the dashboard, go to **📤 Export** → **Download .env**.

Upload to your VPS:
```bash
scp .env your_user@YOUR_VPS_IP:~/.openclaw/.env
```

Then deploy:
```bash
# On your VPS:
cd mktagent3
bash scripts/deploy.sh
```

---

## Step 6 — Test (1 minute)

Find your PM Agent Telegram bot (the one you created with @BotFather).

Send it:
```
Draft a tweet about our latest product update
```

Expected flow:
1. PM Agent receives the message
2. PM classifies intent as SOCIAL
3. PM routes to Social Agent with brand-voice context
4. Social Agent drafts a tweet
5. PM sends draft to Slack #approvals for your review
6. You react ✅ in Slack → PM Agent marks task complete

---

## That's it!

You now have a working agent loop. From here:

**Add more agents** → Go to **🤖 Agents** tab, toggle them on

**Fill more RAG files** → The more context you give, the better the output

**Enable community monitoring** → Fill `community-faq.md` + connect Discord/Telegram bots

**Add BD outreach** → Fill `bd-icp.md` + `bd-email-templates.md` + get an Apollo.io key

---

## Troubleshooting

**Gateway won't start**
```bash
cat /tmp/openclaw-gateway.log
```

**Agent not responding**
```bash
openclaw channels status --probe
```

**RAG file changes not taking effect**
```bash
bash scripts/copy-rag.sh
# No gateway restart needed — takes effect on next conversation
```

**Dashboard can't connect to VPS**
```bash
# Make sure server.py is running on VPS:
python3 dashboard/server.py --port 8765 --token YOUR_TOKEN

# And SSH tunnel is open on your local machine:
ssh -L 8765:localhost:8765 user@YOUR_VPS_IP
```

---

## Next Steps

- [Full README](README.md) — complete architecture and all agent documentation
- [Adding a new agent](docs/ADD_AGENT.md) — build your own agent in 30 minutes
- [Roadmap](docs/ROADMAP.md) — what's coming next
