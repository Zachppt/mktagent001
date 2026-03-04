---
name: web3-mkt-agents-data
description: >
  Data Analysis Agent for Web3 projects. Monitors token price every 5 minutes,
  runs daily competitor scans, generates weekly social and SEO reports, and
  synthesizes insights for PM Agent weekly reports. Read-only — never writes
  to external platforms. Built on GPT-4.1 Nano for maximum cost efficiency.
version: 0.1.0
tags: [web3, analytics, data, token, competitor, seo, kpi]
metadata:
  openclaw:
    requires:
      env:
        - OPENAI_API_KEY
        - GEMINI_API_KEY
        - COINGECKO_API_KEY
        - TWITTER_BEARER_TOKEN
        - LINKEDIN_ACCESS_TOKEN
        - LINKEDIN_COMPANY_ID
        - SERPAPI_KEY
        - GSHEETS_CREDENTIALS
        - GSHEETS_DATA_SHEET_ID
---

# Data Agent — Web3 Analytics & Intelligence

The system's eyes. Collects everything, reports clearly, never editorializes without a label.

## Setup

1. Copy `agents/data/` to `~/.openclaw/workspace-data/`
2. Fill RAG files in `~/.openclaw/workspace-data/rag/`:
   - `competitor-intel.md` — competitor list and keywords to track
   - `alert-thresholds.md` — price/volume alert thresholds + your CoinGecko token ID
   - `kpi-targets.md` — weekly benchmarks for all tracked metrics
   - `seo-keywords.md` — list of keywords to track weekly rankings
3. Register in `openclaw.json` under `agents.list` with `id: "data"`

## What It Does

### Functions
- **token_monitor()** — price every 5min, full metrics hourly; fires alert to PM Agent on ±10% price change or 3x volume spike
- **competitor_scan()** — daily digest of competitor activity, scores 1–3 significance; score=3 triggers immediate PM Agent alert
- **social_analytics()** — Monday morning pull: impressions, engagement rate, follower delta vs KPI targets
- **seo_report()** — Monday keyword rank tracking with week-over-week delta; flags drops >5 positions
- **insights_report()** — synthesizes all data into 3 key weekly insights for PM Agent report

### Output Labels
All outputs are labeled to distinguish raw data from interpretation:
- `[DATA]` — raw API output, no interpretation
- `[SUMMARY]` — compressed data, no interpretation
- `[INSIGHT]` — interpretation, clearly labeled as such

### Alert Thresholds (configured in `rag/alert-thresholds.md`)
- Token price: ±10% in 1 hour → immediate PM Agent alert
- Volume: >3x 7-day average → immediate PM Agent alert
- Competitor: significance score = 3 → immediate PM Agent alert

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| token_monitor() | none (no LLM) | Pure API fetch + numeric comparison |
| competitor_scan() | `openai/gpt-4.1-nano` | Summarization, cheapest available |
| social_analytics() | `openai/gpt-4.1-nano` | Structured data aggregation |
| seo_report() | `openai/gpt-4.1-nano` | Structured data aggregation |
| insights_report() | `google/gemini-2.5-flash` | Synthesis + reasoning required |

**Estimated monthly cost: $2.80**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/competitor-intel.md` | Competitor names, Twitter handles, websites to track |
| `rag/alert-thresholds.md` | CoinGecko token ID, price/volume alert levels |
| `rag/kpi-targets.md` | Weekly targets for all metrics |
| `rag/seo-keywords.md` | Keywords to track + target ranking positions |

Templates: `rag-templates/` in the main repo.

## Monday Morning Sequence

```
08:00  social_analytics()    (this agent)
08:15  seo_report()          (this agent)
08:30  insights_report()     (triggered by PM Agent)
08:45  weekly_report()       (PM Agent assembles)
09:00  SLACK_REVIEW opens
```

## Install Alone
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/data
```

## Install Full Pack
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```

Source: https://github.com/YOUR_USERNAME/web3-mkt-agents
