---
name: web3-mkt-agents-social
description: >
  Social Agent for Web3 projects. Manages Twitter/X and LinkedIn output,
  scans crypto trends every 4 hours, generates meme briefs within 30 minutes
  of trend detection, and logs 7-day engagement for content feedback loops.
  Built on MiniMax M2.5 for speed and cost efficiency.
version: 0.1.0
tags: [web3, marketing, social, twitter, linkedin, meme, trend]
metadata:
  openclaw:
    requires:
      env:
        - MINIMAX_API_KEY
        - OPENAI_API_KEY
        - TWITTER_BEARER_TOKEN
        - TWITTER_API_KEY
        - TWITTER_API_SECRET
        - TWITTER_ACCESS_TOKEN
        - TWITTER_ACCESS_SECRET
        - LINKEDIN_ACCESS_TOKEN
        - LINKEDIN_COMPANY_ID
---

# Social Agent — Web3 Social Media Manager

Handles all social media output for a Web3 project. Fast, on-brand, trend-aware.

## Setup

1. Copy `agents/social/` to `~/.openclaw/workspace-social/`
2. Fill RAG files in `~/.openclaw/workspace-social/rag/`:
   - `brand-voice.md` — your project's tone, vocabulary, forbidden words
   - `meme-templates.md` — approved meme formats your community recognizes
   - `kpi-targets.md` — engagement benchmarks (impressions, likes, follower growth)
3. Register in `openclaw.json` under `agents.list` with `id: "social"`

## What It Does

### Functions
- **trending_scan()** — every 4h, scores crypto trends for relevance (1–5), flags ≥4 to PM Agent
- **post_twitter()** — generates tweet/thread from brief, runs forbidden word check, posts after SLACK_REVIEW
- **meme_trigger()** — generates meme copy + template reference within 30min of trend score ≥4
- **post_linkedin()** — professional-tone post, 150–300 words, posts after SLACK_REVIEW
- **engagement_log()** — Day+7 auto-pull of engagement data, triggers Content Agent feedback loop

### Approval Flow
All outbound posts → **SLACK_REVIEW** → publish on approval
Trend monitoring → **AUTO**

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| Content generation | `minimax/minimax-m2.5` | 100 TPS — meme SLA needs speed, costs 1/20 of Sonnet |
| Keyword scoring | `openai/gpt-4.1-nano` | Cheapest available, pure classification |
| Engagement log | `openai/gpt-4.1-nano` | Structured data read, no generation |

**Estimated monthly cost: $1.75**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/brand-voice.md` | Tone, approved vocabulary, forbidden words list |
| `rag/meme-templates.md` | 10–20 meme formats your community knows, with copy patterns |
| `rag/kpi-targets.md` | Weekly targets: impressions, engagement rate, follower delta |

Templates: `rag-templates/` in the main repo.

## Install Alone
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/social
```

## Install Full Pack
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```

Source: https://github.com/YOUR_USERNAME/web3-mkt-agents
