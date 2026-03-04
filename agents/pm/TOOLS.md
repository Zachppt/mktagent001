# PM Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Slack Bot | Approval pushes, alerts, weekly reports | `SLACK_BOT_TOKEN` | 1 msg/sec |
| Notion API | Task read/write, log archiving | `NOTION_TOKEN` | 3 req/sec |
| OpenClaw sessions | Spawn and message other agents | built-in | — |

---

## Usage Notes

### Slack Bot
```
Used in: monitor_agents(), weekly_report(), dispatch_task() (approval tier 🟡🔴)
Channels:
  #approvals       → SLACK_REVIEW tasks
  #weekly-report   → weekly_report() output
  #alerts          → anomalies, stalled agents
Auth: Bearer $SLACK_BOT_TOKEN
Notes: Always include agent ID and timestamp in every message
```

### Notion API
```
Used in: dispatch_task() (task write-back), weekly_report() (log)
Databases:
  Task DB          → read inbound tasks, write status updates
  Memory Archive   → write compressed memory logs
Auth: Bearer $NOTION_TOKEN
Notes: Use NOTION_TASK_DB_ID and NOTION_MEMORY_DB_ID from config
```

### OpenClaw sessions_send
```
Used in: dispatch_task() (routing to other agents)
Method: sessions_send(agentId, message, context)
Notes: Always include full task context in the message payload — agents have no
       shared memory, so PM must pass everything they need
```

---

## Error Handling

- On Slack 429: wait 10s, retry once; if fail again, log and skip
- On Notion 5xx: log error, retry after 30s, escalate to human after 3 failures
- On agent unresponsive (sessions_send timeout): wait 15min, retry, then alert operator

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Slack, Notion, sessions_send |
