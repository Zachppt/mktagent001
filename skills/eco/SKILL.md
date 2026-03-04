---
name: web3-mkt-agents-eco
description: >
  Ecosystem Agent for Web3 projects. Writes event announcements (4 types),
  runs quarterly brand health audits (scoring consistency, differentiation,
  clarity, community resonance), prospects ecosystem partners, and provides
  brand_checker() as a shared service for Social and Content agents.
version: 0.1.0
tags: [web3, ecosystem, events, brand, partnerships, marketing]
metadata:
  openclaw:
    requires:
      env:
        - MINIMAX_API_KEY
        - OPENAI_API_KEY
        - GEMINI_API_KEY
        - TWITTER_BEARER_TOKEN
        - NOTION_TOKEN
        - NOTION_CRM_DB_ID
        - GCAL_CREDENTIALS
        - GCAL_CALENDAR_ID
---

# Ecosystem Agent — Web3 Ecosystem Marketing

Connects the project to the broader Web3 world. Events, brand, partnerships.

## Setup

1. Copy `agents/eco/` to `~/.openclaw/workspace-eco/`
2. Fill RAG files in `~/.openclaw/workspace-eco/rag/`:
   - `brand-voice.md` — tone, vocabulary, forbidden words
   - `event-formats.md` — templates for 4 event announcement types
   - `ecosystem-icp.md` — ideal ecosystem partner profile
   - `ecosystem-pipeline.md` — start empty, agent populates it
3. Register in `openclaw.json` under `agents.list` with `id: "eco"`

## What It Does

### Functions
- **event_announce()** — generates short (≤280 char) + long (300–500w) variants for PARTICIPATION / HOSTING / SPONSORSHIP / HACKATHON events
- **brand_analysis()** — quarterly brand health audit with 4-dimension score (consistency, differentiation, clarity, resonance)
- **prospect_ecosystem()** — identifies ecosystem partner candidates, scores 1–5, hands off ≥4 to BD Agent
- **brand_checker()** — shared quality gate used by Social and Content agents: forbidden words + tone score + visual reference check

### Approval Model
| Action | Approval |
|--------|---------|
| Event announcement | 🟡 SLACK_REVIEW |
| Brand analysis report | 🟡 SLACK_REVIEW |
| Ecosystem prospecting | AUTO |
| brand_checker() | AUTO (internal) |

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| Event copy | `minimax/minimax-m2.5` | Template-based, speed + cost |
| brand_analysis() | `google/gemini-2.5-flash` | Deep reasoning required |
| prospect_ecosystem() | `openai/gpt-4.1-nano` | Scoring + extraction |
| brand_checker() | `openai/gpt-4.1-nano` | Rule-based check |

**Estimated monthly cost: $1.10**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/brand-voice.md` | Same file as Social/Content agents |
| `rag/event-formats.md` | Templates for each event type with placeholder slots |
| `rag/ecosystem-icp.md` | Ideal partner: ecosystem, stage, team size, complementary product |
| `rag/ecosystem-pipeline.md` | Start empty — agent writes to this |

Templates: `rag-templates/` in the main repo.

## Install
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/eco
```

## Install Full Pack
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```
