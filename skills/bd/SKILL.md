---
name: web3-mkt-agents-bd
description: >
  BD Agent for Web3 projects. Automates prospect research via Apollo.io,
  writes personalized cold emails (5 types), generates HTML partnership
  proposals, and manages 7-day follow-up sequences. All outbound requires
  HUMAN_REQUIRED approval — agent researches and drafts, humans send.
version: 0.1.0
tags: [web3, bd, business-development, cold-email, partnerships, outreach]
metadata:
  openclaw:
    requires:
      env:
        - OPENAI_API_KEY
        - APOLLO_API_KEY
        - HUNTER_API_KEY
        - SENDGRID_API_KEY
        - SENDGRID_FROM_EMAIL
        - NOTION_TOKEN
        - NOTION_BD_DB_ID
---

# BD Agent — Web3 Business Development

Automates BD research and drafting. Humans stay in control of every send.

## Setup

1. Copy `agents/bd/` to `~/.openclaw/workspace-bd/`
2. Fill RAG files in `~/.openclaw/workspace-bd/rag/`:
   - `icp.md` — Ideal Customer Profile (who to target)
   - `email-templates.md` — 5 email type templates
   - `proposal-template.md` — HTML proposal structure
   - `bd-pipeline.md` — prospect pipeline (agent keeps this updated)
   - `event-targets.md` — target conferences and hackathons
3. Register in `openclaw.json` under `agents.list` with `id: "bd"`

## What It Does

### Functions
- **prospect_search()** — Apollo.io ICP-filtered search, deduplicates vs pipeline, scores 1–5
- **cold_email_writer()** — personalized email per type (EXCHANGE / INVESTOR / PROTOCOL_PARTNER / KOL / ECOSYSTEM), A/B subject lines
- **html_proposal()** — self-contained HTML partnership proposal with inline CSS
- **followup_scheduler()** — Day+7 auto-draft for unanswered emails
- **event_scout()** — weekly scan for upcoming Web3 conferences and hackathons

### Approval Model
| Action | Approval |
|--------|---------|
| Prospect research | AUTO |
| Email drafting | AUTO |
| Email send | 🔴 HUMAN_REQUIRED |
| Proposal send | 🔴 HUMAN_REQUIRED |
| Follow-up send | 🔴 HUMAN_REQUIRED |

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| Email writing, proposals | `openai/gpt-4.1` | Best instruction following for structured output |
| Prospect scoring, extraction | `openai/gpt-4.1-nano` | Pure classification, no generation needed |

**Estimated monthly cost: $4–7**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/icp.md` | Target roles, company types, ecosystems, deal size |
| `rag/email-templates.md` | Templates for each outreach type with personalization slots |
| `rag/proposal-template.md` | Standard partnership proposal HTML structure |
| `rag/bd-pipeline.md` | Start empty — agent populates it |
| `rag/event-targets.md` | Conferences, hackathons, meetups worth attending or sponsoring |

Templates: `rag-templates/` in the main repo.

## Install
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/bd
```

## Install Full Pack
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```
