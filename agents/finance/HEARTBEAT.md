# Finance Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 9 * * *` | `budget_tracker()` | `openai/gpt-4.1-nano` | Daily budget vs spend check |
| `0 9 * * *` | `contract_monitor()` | `openai/gpt-4.1-nano` | Daily contract expiry scan |
| `0 10 L * *` | `budget_report()` | primary | Last day of month: full budget report |

---

## Heartbeat Notes

- `budget_tracker()` and `contract_monitor()` run in parallel — both read-only from Notion
- `budget_report()` uses `L` (last day of month) cron syntax — verify your cron implementation supports it; fallback: `0 10 28-31 * *` with a day-of-month check in the script
- Monthly report goes to SLACK_REVIEW before archiving — PM Agent coordinates timing

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
