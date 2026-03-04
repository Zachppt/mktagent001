# Data Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| CoinGecko API | Token price, volume, market cap | `COINGECKO_API_KEY` (optional — free tier works) | 30 req/min (free), 500 req/min (pro) |
| Twitter/X API v2 | Competitor tweet monitoring, own account analytics | `TWITTER_BEARER_TOKEN` | 500k tweets/month (Basic) |
| LinkedIn Analytics API | Company page analytics | `LINKEDIN_ACCESS_TOKEN`, `LINKEDIN_COMPANY_ID` | 100 req/day |
| SerpAPI | Keyword rank tracking | `SERPAPI_KEY` | 100 searches/month (free tier) |
| Google Sheets | Write data outputs for human review | `GSHEETS_CREDENTIALS`, `GSHEETS_DATA_SHEET_ID` | 300 req/min |

---

## Usage Notes

### CoinGecko API
```
Used in: token_monitor()
Price endpoint:   GET /api/v3/simple/price?ids={TOKEN_ID}&vs_currencies=usd&include_24hr_change=true
Market data:      GET /api/v3/coins/{TOKEN_ID}?localization=false&tickers=false&community_data=false
Auth: x-cg-api-key: $COINGECKO_API_KEY (omit header if using free tier without key)
TOKEN_ID:         Set in rag/alert-thresholds.md under coingecko_id field
Notes: Free tier sufficient for monitoring. Pro needed if >30 req/min required.
```

### Twitter/X API v2
```
Used in: competitor_scan() (read competitor tweets), social_analytics() (own account metrics)
Competitor search: GET /2/tweets/search/recent?query={COMPETITOR_HANDLE}&max_results=10
Own metrics:       GET /2/users/{USER_ID}/tweets?tweet.fields=public_metrics&max_results=10
Auth: Bearer $TWITTER_BEARER_TOKEN
Notes: USER_ID for own account metrics — store as TWITTER_OWN_USER_ID in config
```

### Google Sheets
```
Used in: social_analytics(), seo_report() — write structured data for human dashboards
Auth: Service account via $GSHEETS_CREDENTIALS (JSON key path)
Sheet ID: $GSHEETS_DATA_SHEET_ID
Tab naming: "Social_YYYY-MM", "SEO_YYYY-MM", "Token_YYYY-MM"
Notes: Data Agent writes; humans read. Never delete existing rows — append only.
```

---

## Error Handling

- CoinGecko outage: log data gap with timestamp, retry every 5 minutes, notify PM Agent after 30min gap
- Twitter rate limit: back off 15 minutes, retry; critical for competitor_scan (reschedule to next hour)
- SerpAPI quota: notify PM Agent 10% before quota exhaustion; skip non-critical keywords first
- Google Sheets write failure: cache data locally, retry, alert PM Agent if cache exceeds 1h

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: CoinGecko, Twitter, LinkedIn, SerpAPI, Google Sheets |
