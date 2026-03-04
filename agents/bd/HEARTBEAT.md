# BD Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 9 * * 1` | `prospect_search()` | `openai/gpt-4.1-nano` | Monday: refresh prospect pipeline from Apollo.io |
| `0 9 * * 1` | `event_scout()` | `openai/gpt-4.1-nano` | Monday: scan upcoming Web3 events (next 60 days) |
| `0 10 * * *` | `followup_scheduler()` | `openai/gpt-4.1-nano` | Daily: check for emails sent 7 days ago with no reply |

---

## Heartbeat Notes

- `prospect_search()` and `event_scout()` run in parallel Monday morning — both are read-only, no conflicts
- `followup_scheduler()` runs daily but typically fires 0–2 drafts per week depending on outreach volume
- All heartbeat outputs are drafts — none trigger sends without HUMAN_REQUIRED approval

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
