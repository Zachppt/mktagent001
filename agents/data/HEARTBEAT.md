# Data Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `*/5 * * * *` | `token_monitor()` price check | none (no LLM) | Price every 5 min |
| `0 * * * *` | `token_monitor()` full metrics | none (no LLM) | Volume + mktcap hourly |
| `0 8 * * *` | `competitor_scan()` | `openai/gpt-4.1-nano` | Daily competitor digest |
| `0 8 * * 1` | `social_analytics()` | `openai/gpt-4.1-nano` | Monday weekly social pull |
| `15 8 * * 1` | `seo_report()` | `openai/gpt-4.1-nano` | Monday weekly SEO pull (after social) |

---

## Execution Order (Monday Morning)

```
08:00  social_analytics()   → data packet ready
08:15  seo_report()         → rankings ready
08:30  insights_report()    → triggered by PM Agent once both are ready
08:45  weekly_report()      → PM Agent assembles full report
09:00  human review window  → SLACK_REVIEW
```

---

## Heartbeat Notes

- `token_monitor()` price check requires zero LLM calls — pure API fetch + numeric threshold comparison
- `competitor_scan()` uses GPT-4.1 Nano for summarization only — cheapest model that can read and summarize text
- Monday morning sequence is time-sensitive — PM Agent must be online and ready to receive data packets

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
