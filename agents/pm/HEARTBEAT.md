# PM Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 * * * *` | `monitor_agents()` | `google/gemini-2.5-flash-lite` | Hourly agent health check |
| `0 9 * * 1` | `weekly_report()` | primary | Monday 9am weekly KPI report |
| `0 23 * * 5` | `memory_compress()` | `minimax/minimax-m2.5` | Friday night memory compression |

---

## Heartbeat Notes

- `monitor_agents()` runs silently — only outputs to Slack if anomaly detected
- `weekly_report()` output goes to `#weekly-report` and requires SLACK_REVIEW before forwarding
- `memory_compress()` archives originals before overwriting — never destructive

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
