# Community Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `*/15 * * * *` | `sentiment_scan()` | `openai/gpt-4o-mini` | Every 15 min: sentiment score Discord + TG |

---

## Heartbeat Notes

- `sentiment_scan()` is the highest-frequency task in the entire system — 2,880 runs/month
- **Must use the cheapest possible model** — GPT-4o Mini at $0.15/M input
- If 3 consecutive cycles are missed (45 min gap): PM Agent should alert operator — community is unwatched
- `auto_reply()` is event-driven (not scheduled) — fires on inbound message detection, not cron

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
