# {{AGENT_NAME}} — TOOLS.md

<!--
  TOOLS.md documents every external tool / API this agent uses.
  This is the agent's reference — keep it accurate and up to date.
-->

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| `{{tool_name}}` | {{purpose}} | `{{ENV_VAR_NAME}}` | {{e.g. 100 req/min}} |

---

## Usage Notes

### {{tool_name}}
```
Endpoint: {{url or description}}
Auth: Bearer ${{ENV_VAR_NAME}}
Used in: {{function_name}}()
Notes: {{any quirks, pagination, retry logic}}
```

---

## Error Handling

- On 429 (rate limit): wait 60s, retry once
- On 5xx: log error, notify PM Agent, skip task
- On auth failure: immediately notify PM Agent — do not retry

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial template |
