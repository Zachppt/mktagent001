# Ecosystem Agent — HEARTBEAT.md

## Scheduled Tasks

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| `0 9 * * 1` | `prospect_ecosystem()` | `openai/gpt-4.1-nano` | Monday: refresh ecosystem partner prospects |
| `0 10 1 */3 *` | `brand_analysis()` | `google/gemini-2.5-flash` | Quarterly (1st of Jan/Apr/Jul/Oct): brand health audit |

---

## Heartbeat Notes

- `prospect_ecosystem()` runs after BD Agent's `prospect_search()` on Mondays — score ≥ 4 results are handed off to BD Agent via PM Agent
- `brand_analysis()` runs quarterly — PM Agent is notified in advance to prepare supporting data from Social and Data agents
- All outputs require SLACK_REVIEW before any external distribution

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release |
