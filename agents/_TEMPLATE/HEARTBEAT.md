# {{AGENT_NAME}} — HEARTBEAT.md

<!--
  HEARTBEAT defines all scheduled / recurring tasks.
  Format: cron expression | function | model | description
  
  Cron quick reference:
  "0 * * * *"      = every hour
  "0 9 * * 1"      = every Monday 9am
  "*/15 * * * *"   = every 15 minutes
  "0 0 * * 5"      = every Friday midnight
-->

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `{{cron_expression}}` | `{{function_name}}()` | `{{model or "primary"}}` | {{what it does}} |

<!--
  Example:
  | `0 */4 * * *`  | `trending_scan()`  | `openai/gpt-4.1-nano` | Scan Twitter trends every 4h |
  | `0 9 * * 1`    | `weekly_report()`  | primary               | Monday morning KPI report    |
-->

---

## Heartbeat Notes

- All heartbeat tasks run at lowest available priority
- On failure: log to memory, notify PM Agent
- Heavy tasks (analysis, reports) use cheaper model overrides where specified

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial template |
