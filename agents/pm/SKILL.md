---
name: web3-mkt-agents-pm
description: >
  PM Agent for Web3 marketing teams. Central orchestrator that routes tasks to
  specialist agents, runs hourly health checks, generates weekly KPI reports,
  and enforces a 3-tier approval system (AUTO / SLACK_REVIEW / HUMAN_REQUIRED).
  Part of the web3-mkt-agents framework — works standalone or with other agents.
version: 0.1.0
tags: [web3, marketing, pm, orchestrator, multi-agent]
metadata:
  openclaw:
    requires:
      env:
        - ANTHROPIC_API_KEY
        - SLACK_BOT_TOKEN
        - NOTION_TOKEN
        - NOTION_TASK_DB_ID
        - NOTION_MEMORY_DB_ID
---

# PM Agent — Web3 Marketing Orchestrator

Central task router and system monitor for the web3-mkt-agents framework.

## Setup

1. Copy `agents/pm/` to `~/.openclaw/workspace-pm/`
2. Fill RAG files in `~/.openclaw/workspace-pm/rag/`:
   - `routing-rules.md` — intent classification rules
   - `kpi-targets.md` — weekly performance benchmarks
   - `crisis-sop.md` — escalation playbook
   - `agent-registry.md` — which agents are live
3. Register in `openclaw.json` under `agents.list` with `id: "pm"` and `default: true`

## What It Does

### Functions
- **dispatch_task()** — classifies any inbound request and routes to the right agent
- **monitor_agents()** — hourly health check across all active agents (runs on Gemini 2.5 Flash-Lite)
- **weekly_report()** — Monday morning KPI summary aggregated from all agents
- **memory_compress()** — Friday night memory distillation across all agent workspaces
- **kpi_check()** — compares actuals vs targets, flags misses with recommendations

### Approval System Enforced
| Tier | When | PM Action |
|------|------|-----------|
| 🟢 AUTO | Monitoring, routing, data reads | Execute silently |
| 🟡 SLACK_REVIEW | Content, announcements, alerts | Post to #approvals |
| 🔴 HUMAN_REQUIRED | Outbound, financial, crisis | DM operator, halt |

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| Main conversations | `anthropic/claude-sonnet-4-6` | Best instruction following, operator-facing |
| monitor_agents() | `google/gemini-2.5-flash-lite` | 720 calls/month — keep cost near zero |
| memory_compress() | `minimax/minimax-m2.5` | Summarization task, no reasoning needed |
| kpi_check() | `openai/gpt-4.1-nano` | Structured comparison, no generation |

**Estimated monthly cost: $9–19**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/routing-rules.md` | Keywords and patterns that map to each agent |
| `rag/kpi-targets.md` | Your weekly targets: impressions, followers, posts, etc. |
| `rag/crisis-sop.md` | Step-by-step crisis response (who to call, what to post) |
| `rag/agent-registry.md` | List of active agents with their capabilities |

Templates for all RAG files: `rag-templates/` in the main repo.

## Install Alone
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/pm
```

## Install Full Pack
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```

Source: https://github.com/YOUR_USERNAME/web3-mkt-agents
