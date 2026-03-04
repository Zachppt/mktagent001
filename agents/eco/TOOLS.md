# Ecosystem Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Notion API | Ecosystem pipeline read/write | `NOTION_TOKEN`, `NOTION_CRM_DB_ID` | 3 req/sec |
| Twitter/X API v2 | Ecosystem prospect research (read-only) | `TWITTER_BEARER_TOKEN` | 500k tweets/month |
| Google Calendar | Event deadline sync | `GCAL_CREDENTIALS`, `GCAL_CALENDAR_ID` | 1M req/day |

---

## Usage Notes

### Notion CRM DB
```
Used in: prospect_ecosystem() (write), event_announce() (log)
Database: $NOTION_CRM_DB_ID
Fields: ProjectName, Twitter, Website, EcosystemScore, Status, HandoffDate, Notes
Status values: NEW | QUALIFIED | HANDED_TO_BD | PARTNERSHIP | DEAD
Notes: Eco Agent writes; BD Agent and humans update Status
```

### Twitter/X — Ecosystem Research
```
Used in: prospect_ecosystem() (read-only, research)
Purpose: Check follower count, activity level, recent mentions of the project
Endpoint: GET /2/users/by/username/{username}?user.fields=public_metrics
Auth: Bearer $TWITTER_BEARER_TOKEN
Notes: Read-only. Never post from this agent via Twitter API directly.
```

### Google Calendar
```
Used in: event_announce() (sync event deadlines and speaking slots)
Auth: Service account via $GCAL_CREDENTIALS
Calendar: $GCAL_CALENDAR_ID
Notes: Eco Agent writes event dates and application deadlines; humans manage attendance
```

---

## Error Handling

- Notion write failure: cache locally, retry after 30s, alert PM Agent after 3 failures
- Twitter API unavailable: skip ecosystem scoring step, log gap, continue with available data
- Calendar sync failure: log event locally in memory, notify PM Agent to add manually

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Notion CRM, Twitter research, Google Calendar |
