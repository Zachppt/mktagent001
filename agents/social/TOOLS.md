# Social Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Twitter/X API v2 | Post tweets, read trends, fetch analytics | `TWITTER_BEARER_TOKEN`, `TWITTER_API_KEY`, `TWITTER_API_SECRET`, `TWITTER_ACCESS_TOKEN`, `TWITTER_ACCESS_SECRET` | 300 req/15min (read), 200 tweets/15min (write) |
| LinkedIn API | Post to company page | `LINKEDIN_ACCESS_TOKEN`, `LINKEDIN_COMPANY_ID` | 100 req/day |

---

## Usage Notes

### Twitter/X API v2
```
Post tweet:    POST /2/tweets
Read trends:   GET  /2/trends/by/woeid/{woeid}  (woeid=1 for worldwide)
Get analytics: GET  /2/tweets/{id}?tweet.fields=public_metrics
Auth: OAuth 2.0 Bearer token for reads; OAuth 1.0a for writes
Notes:
  - Trends endpoint requires Academic or Pro access
  - Fallback for trends: scrape via nitter instance if API unavailable
  - Always include tweet ID in memory log after successful post
```

### LinkedIn API
```
Post to page:  POST /v2/ugcPosts
Auth: Bearer $LINKEDIN_ACCESS_TOKEN
Company page:  Use $LINKEDIN_COMPANY_ID in author field
Notes:
  - Access token expires every 60 days — alert PM Agent 7 days before expiry
  - Rate limit is per-app, not per-user
```

---

## Error Handling

- Twitter 429 (rate limit): wait 15min, retry; if still rate limited, log and skip
- Twitter auth failure: escalate to PM Agent immediately, queue post for retry
- LinkedIn token expiry warning (7-day notice): notify operator via PM Agent
- Any API 5xx: log error with full response body, retry after 60s, max 3 retries

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Twitter/X v2, LinkedIn |
