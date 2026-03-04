# Content Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 9 * * 1` | `performance_learn()` | `google/gemini-2.5-flash` | Monday morning: process prior week's engagement feedback from Data Agent |

---

## Heartbeat Notes

- `performance_learn()` depends on Data Agent having completed its weekly engagement pull first
- PM Agent coordinates sequencing: Data Agent runs → sends signal → Content Agent performance_learn() fires
- No direct publish tasks are scheduled — all content is triggered on-demand by PM Agent

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
