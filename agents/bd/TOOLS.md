# BD Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Apollo.io API | Prospect search and enrichment | `APOLLO_API_KEY` | 50 req/min (basic) |
| Hunter.io API | Email verification | `HUNTER_API_KEY` | 50 verifications/month (free tier) |
| SendGrid API | Email send (HUMAN_REQUIRED only) | `SENDGRID_API_KEY`, `SENDGRID_FROM_EMAIL` | 100/day (free tier) |
| Notion API | BD pipeline read/write | `NOTION_TOKEN`, `NOTION_BD_DB_ID` | 3 req/sec |

---

## Usage Notes

### Apollo.io API
```
Used in: prospect_search()
Endpoint: POST https://api.apollo.io/v1/mixed_people/search
Auth: api_key in request body
Key filters:
  - person_titles: ["CMO", "Head of Marketing", "BD Lead", "Partnerships"]
  - organization_industry_tag_ids: [crypto/blockchain IDs]
  - organization_num_employees_ranges: set per ICP
Notes: Map ICP criteria from rag/icp.md to Apollo filter fields before each search
```

### Hunter.io API
```
Used in: cold_email_writer() (pre-draft verification)
Endpoint: GET https://api.hunter.io/v2/email-verifier?email={email}&api_key=$HUNTER_API_KEY
Result codes:
  - "deliverable" → proceed
  - "risky" → flag in draft, let human decide
  - "undeliverable" / "unknown" → do not draft, notify PM Agent
Notes: Free tier = 50/month. Prioritize for score ≥ 4 prospects only.
```

### SendGrid API
```
Used in: email send — ONLY after HUMAN_REQUIRED approval received
Endpoint: POST https://api.sendgrid.com/v3/mail/send
Auth: Bearer $SENDGRID_API_KEY
From: $SENDGRID_FROM_EMAIL (must be verified sender)
Notes:
  - Always include unsubscribe header
  - Log message_id to memory immediately after send
  - Track opens/clicks if SendGrid plan supports it
```

### Notion BD Pipeline
```
Used in: prospect_search() (write), followup_scheduler() (read/write)
Database: $NOTION_BD_DB_ID
Fields: Name, Company, Email, Score, Status, LastContact, Notes
Status values: NEW | EMAILED | REPLIED | CALL_BOOKED | CLOSED | DEAD
Notes: BD Agent writes prospect data; humans update Status after calls
```

---

## Error Handling

- Apollo.io 429: back off 60s, retry once; if fails again, log and skip weekly run
- Hunter.io quota exhausted: notify PM Agent, skip verification for that week (log unverified flag)
- SendGrid auth failure: escalate to PM Agent immediately — do not queue emails
- Notion write failure: cache locally, retry after 30s, alert PM Agent after 3 failures

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Apollo.io, Hunter.io, SendGrid, Notion BD pipeline |
