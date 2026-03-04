---
name: web3-mkt-agents-content
description: >
  Content Agent for Web3 projects. Produces blog posts (5 types), video scripts
  with storyboards, and design briefs. Runs internal quality gates (forbidden
  word check, brand consistency, SEO density) before every SLACK_REVIEW
  submission. Learns from engagement data via Day+7 feedback loop.
version: 0.1.0
tags: [web3, marketing, content, blog, seo, video, design]
metadata:
  openclaw:
    requires:
      env:
        - ANTHROPIC_API_KEY
        - OPENAI_API_KEY
        - NOTION_TOKEN
        - NOTION_CONTENT_DB_ID
        - SERPAPI_KEY
---

# Content Agent — Web3 Content Production

Long-form content engine for Web3 projects. Blog, video, design — all on-brand, all SEO-optimized.

## Setup

1. Copy `agents/content/` to `~/.openclaw/workspace-content/`
2. Fill RAG files in `~/.openclaw/workspace-content/rag/`:
   - `brand-voice.md` — tone, vocabulary, forbidden words
   - `content-style.md` — writing style guide with examples
   - `design-guidelines.md` — visual brand guidelines for banner briefs
   - `kpi-targets.md` — content performance benchmarks
3. Register in `openclaw.json` under `agents.list` with `id: "content"`

## What It Does

### Functions
- **blog_writer()** — 5 post types (SOCIAL_TREND / GUIDANCE / UPDATE / PEAK_INSIGHT / ANNOUNCEMENT), 500–2000 words, SEO-optimized
- **video_script()** — scene-by-scene script with storyboard notes, hook-to-CTA structure
- **banner_brief()** — headline (≤6w), subheadline (≤12w), CTA (≤3w), visual direction
- **content_review()** — internal gate: forbidden words + brand consistency + SEO density + readability
- **performance_learn()** — Monday morning analysis of prior week's engagement patterns from Data Agent

### Blog Post Types

| Type | Length | When |
|------|--------|------|
| SOCIAL_TREND | 800–1000w | Trend score ≥4 from Social Agent |
| GUIDANCE | 1200–1500w | On-demand (tutorials, how-tos) |
| UPDATE | 500–800w | Product / milestone events |
| PEAK_INSIGHT | 1500–2000w | Strategic thought leadership |
| ANNOUNCEMENT | 400–600w | Partnerships, listings |

### Quality Gate (auto-runs before every SLACK_REVIEW)
1. Forbidden word scan → hard block on match
2. Brand consistency score (1–5) → must be ≥4
3. SEO keyword density (1–3%) → flag if out of range
4. Sentence length → flag sentences >25 words

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| All writing | `anthropic/claude-sonnet-4-6` | Brand voice + long-form reasoning |
| content_review() | `openai/gpt-4.1-nano` | Rule-based check, cheapest |
| performance_learn() | `google/gemini-2.5-flash` | Synthesis + pattern detection |

**Estimated monthly cost: $6–12**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/brand-voice.md` | Tone, approved vocabulary, forbidden words |
| `rag/content-style.md` | Writing patterns, past examples, style rules |
| `rag/design-guidelines.md` | Colors, fonts, visual do/don't for banner briefs |
| `rag/kpi-targets.md` | Benchmarks: avg read time, shares, backlinks |

Templates: `rag-templates/` in the main repo.

## Install Alone
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/content
```

## Install Full Pack
```bash
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```

Source: https://github.com/YOUR_USERNAME/web3-mkt-agents
