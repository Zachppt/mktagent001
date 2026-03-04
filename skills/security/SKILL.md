---
name: web3-mkt-agents-security
description: >
  Security Agent for Web3 projects. Read-only threat monitor — scans for
  impersonator accounts every 6 hours, checks for phishing domains twice daily,
  audits API key usage weekly, and monitors all official accounts for anomalies.
  Never takes action on external platforms — alerts only. Built on Gemini 2.5
  Flash-Lite for near-zero cost at high scan frequency.
version: 0.1.0
tags: [web3, security, impersonation, phishing, monitoring, audit]
metadata:
  openclaw:
    requires:
      env:
        - GEMINI_API_KEY
        - TWITTER_BEARER_TOKEN
        - GOOGLE_SAFE_BROWSING_KEY
        - WHOISXML_API_KEY
        - SLACK_BOT_TOKEN
---

# Security Agent — Web3 Threat Monitor

Always-on, read-only threat detection for Web3 projects. Sees everything, acts on nothing, reports everything.

## Setup

1. Copy `agents/security/` to `~/.openclaw/workspace-security/`
2. Fill RAG files in `~/.openclaw/workspace-security/rag/`:
   - `impersonation-keywords.md` — project name variants, token symbol, founder handles
   - `phishing-patterns.md` — official domains to protect, typosquat patterns
   - `api-audit-config.md` — expected API usage baselines and anomaly thresholds
   - `monitored-accounts.md` — all official project accounts across all platforms
3. Register in `openclaw.json` under `agents.list` with `id: "security"`

## What It Does

### Functions
- **impersonation_scan()** — every 6h: searches Twitter/X for accounts matching project name variants and impersonation patterns; scores 1–3; alerts PM Agent on score ≥ 2
- **phishing_scan()** — twice daily: checks for typosquatting domains and fake airdrop/claim sites via Google Safe Browsing + WHOIS; alerts PM Agent on score ≥ 2
- **api_audit()** — weekly (Sunday): pulls API usage logs, flags >2x normal volume or off-hours calls, generates API health report for weekly_report()
- **account_monitor()** — daily: checks all official accounts for unexpected bio changes, follower drops >10%, or unusual post volume; alerts PM Agent on anomaly
- **security_alert()** — called by all functions above on score ≥ 2: formats and posts to Slack `#security-alerts`

### Severity Scale
| Score | Meaning | Action |
|-------|---------|--------|
| 1 | FYI — low risk | Memory log only |
| 2 | Likely threat | PM Agent + #security-alerts |
| 3 | Active threat | PM Agent + operator direct + HUMAN_REQUIRED |

### Hard Constraint
**This agent has zero write permissions on external platforms.** It holds no platform API keys with write access. All alerts go through PM Agent → Slack. Human decides all response actions.

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| All tasks | `google/gemini-2.5-flash-lite` | Pattern matching only, no generation — cheapest |

**Estimated monthly cost: $0.45**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/impersonation-keywords.md` | 20–30 variants of your project name, token, founder handles |
| `rag/phishing-patterns.md` | Your official domains, common typosquat patterns to check |
| `rag/api-audit-config.md` | Expected weekly call volumes per API key, anomaly thresholds |
| `rag/monitored-accounts.md` | Every official account: platform, handle, expected follower range |

Templates: `rag-templates/` in the main repo.

## Install
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/security
```

## Install Full Pack
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```

Source: https://github.com/YOUR_USERNAME/web3-mkt-agents
