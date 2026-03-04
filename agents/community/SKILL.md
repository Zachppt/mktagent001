---
name: web3-mkt-agents-community
description: >
  Community Agent for Web3 projects. Monitors Discord and Telegram sentiment
  every 15 minutes, auto-replies to FAQ questions within 2 minutes, drafts
  crisis responses for human approval, and distributes announcements across
  both platforms. Uses GPT-4o Mini for high-frequency monitoring tasks.
version: 0.1.0
tags: [web3, community, discord, telegram, sentiment, faq, crisis]
metadata:
  openclaw:
    requires:
      env:
        - OPENAI_API_KEY
        - ANTHROPIC_API_KEY
        - DISCORD_BOT_TOKEN
        - DISCORD_GUILD_ID
        - DISCORD_MONITOR_CHANNEL_IDS
        - DISCORD_ANNOUNCE_CHANNEL_ID
        - TG_TOKEN_COMMUNITY
        - TG_COMMUNITY_CHAT_ID
        - TG_CHANNEL_ID
---

# Community Agent — Web3 Community Management

Always-on Discord and Telegram management. Sentiment monitoring every 15 minutes, FAQ replies in under 2 minutes.

## Setup

1. Copy `agents/community/` to `~/.openclaw/workspace-community/`
2. Fill RAG files in `~/.openclaw/workspace-community/rag/`:
   - `faq-knowledge-base.md` — 50+ Q&A pairs (the more, the better)
   - `crisis-sop.md` — crisis levels and response playbook
   - `brand-voice.md` — community tone and vocabulary
   - `moderator-guidelines.md` — rules, escalation paths, mute/ban criteria
3. Register in `openclaw.json` under `agents.list` with `id: "community"`

## What It Does

### Functions
- **sentiment_scan()** — every 15 min; scores POSITIVE/NEUTRAL/NEGATIVE/CRISIS; alerts at <60% positive (SLACK) and <40% (HUMAN_REQUIRED)
- **auto_reply()** — FAQ-matched replies posted within 2 minutes; TECHNICAL questions escalated to human
- **crisis_draft()** — generates holding statement + FAQ addendum + moderator talking points; HUMAN_REQUIRED before any post
- **community_update()** — formats and distributes announcements to Discord + TG simultaneously after SLACK_REVIEW

### Sentiment Thresholds
| Ratio | Action |
|-------|--------|
| ≥ 60% positive | Silent log |
| < 60% positive | 🟡 SLACK_REVIEW alert |
| < 40% positive | 🔴 HUMAN_REQUIRED |
| Any CRISIS tag | 🔴 HUMAN_REQUIRED immediately |

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| sentiment_scan(), auto_reply(), community_update() | `openai/gpt-4o-mini` | 2,880 runs/month — must be cheapest |
| crisis_draft() | `anthropic/claude-sonnet-4-6` | Quality non-negotiable in a crisis |

**Estimated monthly cost: $1.90**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/faq-knowledge-base.md` | Q&A pairs covering: staking, tokenomics, how-to, partnerships, roadmap |
| `rag/crisis-sop.md` | L1/L2/L3 crisis definitions and response scripts |
| `rag/brand-voice.md` | Community tone — how the project talks to its own community |
| `rag/moderator-guidelines.md` | What gets warned, muted, banned; escalation contacts |

Templates: `rag-templates/` in the main repo.

## Install
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/community
```

## Install Full Pack
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```
