# Monitored Accounts
<!--
  INSTRUCTIONS:
  Used by Security Agent account_monitor() daily.
  List every official project account across all platforms.
  The agent checks these for anomalies: unexpected bio changes,
  follower drops >10%, unusual post volume.
  Delete these comment blocks before deploying.
-->

## Twitter / X

| Account | Handle | Type | Expected Followers | Expected Posts/Week | Notes |
|---------|--------|------|--------------------|---------------------|-------|
| Main project | `@[handle]` | PRIMARY | ~[current count] | 5–15 | High priority |
| Ecosystem | `@[handle]` | SECONDARY | ~[current count] | 2–7 | |
| [Founder name] | `@[handle]` | FOUNDER | ~[current count] | 3–10 | |
| [add more] | | | | | |

**Anomaly thresholds for Twitter:**
- Follower drop: > 10% in 24h → alert
- Bio change: any unexpected change → alert
- Verification removed: immediately → score 3 alert
- Posts: 0 for 7+ days on active account → FYI alert

---

## Telegram

| Account/Channel | Handle/ID | Type | Expected Members | Notes |
|----------------|----------|------|-----------------|-------|
| Main community | `@[handle]` | GROUP | ~[current count] | |
| Announcement channel | `@[handle]` | CHANNEL | ~[current count] | |
| [add more] | | | | |

**Anomaly thresholds for Telegram:**
- Member drop: > 15% in 24h → alert
- Channel admin changed: immediately → score 3 alert

---

## Discord

| Server | Guild ID | Expected Members | Notes |
|--------|---------|-----------------|-------|
| Main server | `[GUILD_ID]` | ~[current count] | |

**Anomaly thresholds for Discord:**
- Member drop: > 10% in 24h → alert
- Server owner changed: immediately → score 3 alert (rare but possible via invite link hijack)

---

## LinkedIn

| Page | URL | Expected Followers | Notes |
|------|-----|-------------------|-------|
| Company page | linkedin.com/company/[slug] | ~[count] | |

---

## GitHub

| Repo | URL | Stars (approx) | Notes |
|------|-----|---------------|-------|
| Main repo | github.com/[org]/[repo] | ~[count] | Check for unexpected forks or stars drops |

---

## Website / Domains

| Site | URL | Uptime Expectation | Notes |
|------|-----|-------------------|-------|
| Main website | https://[yourproject.io] | 99.9% | Core |
| App | https://app.[yourproject.io] | 99.9% | Core |
| Docs | https://docs.[yourproject.io] | 99% | |

**Check**: If main website is down >15 min during business hours → score 2 alert to PM Agent.

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
