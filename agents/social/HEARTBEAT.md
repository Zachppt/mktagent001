# Social Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 */4 * * *` | `trending_scan()` | `openai/gpt-4.1-nano` | Scan crypto Twitter trends every 4 hours |
| `0 8 * * 1,3,5` | `engagement_log()` | `openai/gpt-4.1-nano` | Check engagement on posts from 7 days prior (Mon/Wed/Fri) |

---

## Heartbeat Notes

- `trending_scan()` runs silently — only surfaces to PM Agent if score ≥ 4
- `engagement_log()` schedule assumes posts go out Mon/Wed/Fri — adjust to your posting cadence
- Both tasks use cheap model overrides (GPT-4.1 Nano) — no generation required

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
