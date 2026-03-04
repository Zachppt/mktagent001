# Security Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 */6 * * *` | `impersonation_scan()` | `google/gemini-2.5-flash-lite` | Scan for impersonator accounts every 6 hours |
| `0 */12 * * *` | `phishing_scan()` | `google/gemini-2.5-flash-lite` | Phishing domain scan twice daily |
| `0 22 * * 0` | `api_audit()` | `google/gemini-2.5-flash-lite` | Weekly API usage audit (Sunday 10pm) |
| `0 7 * * *` | `account_monitor()` | `google/gemini-2.5-flash-lite` | Daily official account health check |

---

## Heartbeat Notes

- All tasks run on `google/gemini-2.5-flash-lite` — they are pure read + pattern match, no generation needed
- Total LLM calls: ~(4 × 30) + (2 × 30) + 4 + 30 = ~184/month — extremely cheap
- `api_audit()` runs Sunday night to be ready for Monday's `weekly_report()` assembly
- `account_monitor()` runs at 07:00 so any overnight anomalies are caught before business hours
- If any scheduled scan fails (API outage, etc.) → log the gap to memory, retry at next scheduled cycle

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
