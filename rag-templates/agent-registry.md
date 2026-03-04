# Agent Registry
<!--
  INSTRUCTIONS:
  Used by PM Agent: dispatch_task(), monitor_agents(), weekly_report()
  This file is the single source of truth for which agents are active,
  what they can do, and how to reach them.

  Update this file when you:
  - Enable or disable an agent
  - Add a new agent to the system
  - Change an agent's Telegram bot or workspace path

  Delete these comment blocks before deploying.
-->

## Active Agents

| Agent ID | Name | Status | Primary Model | Telegram Bot |
|----------|------|--------|--------------|-------------|
| `pm` | PM Agent | ✅ ACTIVE | claude-sonnet-4-6 | [@YOUR_PM_BOT] |
| `social` | Social Agent | ✅ ACTIVE | minimax-m2.5 | [@YOUR_SOCIAL_BOT] |
| `content` | Content Agent | ✅ ACTIVE | claude-sonnet-4-6 | [@YOUR_CONTENT_BOT] |
| `data` | Data Agent | ✅ ACTIVE | gpt-4.1-nano | [@YOUR_DATA_BOT] |
| `bd` | BD Agent | ✅ ACTIVE | gpt-4.1 | [@YOUR_BD_BOT] |
| `community` | Community Agent | ✅ ACTIVE | gpt-4o-mini | [@YOUR_COMMUNITY_BOT] |
| `eco` | Eco Agent | ✅ ACTIVE | minimax-m2.5 | [@YOUR_ECO_BOT] |
| `finance` | Finance Agent | ✅ ACTIVE | claude-sonnet-4-6 | [@YOUR_FINANCE_BOT] |
| `security` | Security Agent | ✅ ACTIVE | gemini-2.5-flash-lite | [@YOUR_SECURITY_BOT] |

---

## Agent Capabilities

### 🧠 PM Agent
- Routes and classifies all inbound tasks
- Monitors agent health hourly
- Generates weekly KPI report (Monday 09:00)
- Compresses all agent memories (Friday 23:00)
- Owns the 3-tier approval system

### 📣 Social Agent
- Drafts and schedules Twitter/X posts
- Drafts LinkedIn posts
- Creates meme copy from templates
- Monitors trending topics in crypto/web3

### ✍️ Content Agent
- Writes blog posts and articles
- Creates video scripts
- Writes design briefs and banner copy
- Runs brand compliance checks on all content

### 📊 Data Agent
- Monitors token price and volume (5-min intervals)
- Scans competitor Twitter/X activity (daily)
- Tracks SEO keyword rankings (weekly)
- Generates analytics reports for PM Agent

### 🤝 BD Agent
- Finds exchange, protocol, and KOL leads via Apollo.io
- Drafts cold outreach emails
- Manages BD pipeline in Notion
- Scouts events and conferences

### 💬 Community Agent
- Monitors Discord and Telegram sentiment
- Auto-replies to FAQ messages
- Drafts crisis communication for human review
- Sends announcements across community channels

### 🌐 Eco Agent
- Finds ecosystem partnership prospects
- Drafts event announcement copy
- Analyzes brand positioning vs ecosystem projects

### 💰 Finance Agent
- Logs invoices from PDF input to Notion
- Tracks spend vs monthly budget
- Alerts on budget threshold breaches
- Generates monthly finance summary

### 🛡️ Security Agent
- Scans Twitter/X for impersonation accounts (daily)
- Monitors phishing links in community channels
- Audits API key exposure in public repos (weekly)
- Flags suspicious login activity

---

## Workspace Paths

| Agent | Workspace |
|-------|-----------|
| PM | `~/.openclaw/workspace-pm/` |
| Social | `~/.openclaw/workspace-social/` |
| Content | `~/.openclaw/workspace-content/` |
| Data | `~/.openclaw/workspace-data/` |
| BD | `~/.openclaw/workspace-bd/` |
| Community | `~/.openclaw/workspace-community/` |
| Eco | `~/.openclaw/workspace-eco/` |
| Finance | `~/.openclaw/workspace-finance/` |
| Security | `~/.openclaw/workspace-security/` |

---

## Disabling an Agent

To disable an agent:
1. Change status to `⏸ PAUSED` in the table above
2. Remove the agent from `config/openclaw.json` active agents list
3. Run `openclaw gateway reload`
4. PM Agent will stop routing tasks to that agent automatically

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup — all 9 agents active |
