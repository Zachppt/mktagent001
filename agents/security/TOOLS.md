# Security Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Twitter/X API v2 | Impersonation account search | `TWITTER_BEARER_TOKEN` | 500k tweets/month |
| Google Safe Browsing API | Phishing / malware domain check | `GOOGLE_SAFE_BROWSING_KEY` | 10k req/day (free) |
| WHOIS API | Domain registration lookup for typosquats | `WHOISXML_API_KEY` | 500 req/month (free) |

---

## Usage Notes

### Twitter/X API v2 — Impersonation Search
```
Used in: impersonation_scan()
Endpoint: GET /2/users/search?query={keyword}&user.fields=description,created_at,public_metrics
Endpoint: GET /2/tweets/search/recent?query={keyword}&tweet.fields=author_id,created_at
Auth: Bearer $TWITTER_BEARER_TOKEN
Notes:
  - Search each keyword variant from rag/impersonation-keywords.md separately
  - Filter out verified/known accounts from results (whitelist in rag/monitored-accounts.md)
  - Capture: username, display_name, follower_count, created_at, recent_tweet_sample
  - New accounts (<30 days old) with high follower counts get automatic score bump to 2
```

### Google Safe Browsing API
```
Used in: phishing_scan()
Endpoint: POST https://safebrowsing.googleapis.com/v4/threatMatches:find
Auth: key=$GOOGLE_SAFE_BROWSING_KEY
Threat types: MALWARE, SOCIAL_ENGINEERING, UNWANTED_SOFTWARE, POTENTIALLY_HARMFUL_APPLICATION
Notes:
  - Check all domains from rag/phishing-patterns.md suspicious domain list
  - Any hit on SOCIAL_ENGINEERING = automatic score 3
  - Free tier: 10k lookups/day — more than enough for this use case
```

### WHOIS API
```
Used in: phishing_scan() — typosquatting detection
Endpoint: GET https://www.whoisxmlapi.com/whoisserver/WhoisService?domainName={domain}&apiKey=$WHOISXML_API_KEY
Notes:
  - Generate typosquat variants from official domain (see rag/phishing-patterns.md for variant patterns)
  - Flag domains: registered <90 days ago AND similar to official domain
  - Capture: registrar, creation_date, registrant (if public), nameservers
  - Free tier: 500 req/month — use sparingly, only check new variants each run
```

---

## Read-Only Enforcement

This agent has **no write credentials** for any external platform. It does not hold:
- Twitter API write tokens
- Discord bot write permissions
- Telegram bot send permissions
- Any platform moderation keys

All alerts go exclusively through PM Agent → Slack `#security-alerts`.

---

## Error Handling

- Twitter API down: log scan gap to memory, retry at next scheduled cycle; notify PM Agent if gap > 12h
- Safe Browsing quota exceeded: notify PM Agent immediately (security compromise risk)
- WHOIS API quota low (<50 remaining): notify PM Agent to refresh quota before next billing cycle
- Any API returning unexpected schema: log raw response, skip parsing, flag to PM Agent

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Twitter search, Google Safe Browsing, WHOIS |
