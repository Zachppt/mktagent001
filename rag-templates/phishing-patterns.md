# Phishing Patterns
<!--
  INSTRUCTIONS:
  Used by Security Agent phishing_scan() twice daily.
  List your official domains and the typosquat patterns to check.
  Delete these comment blocks before deploying.
-->

## Official Domains (Never Flag)

| Domain | Purpose |
|--------|---------|
| `[yourproject.io]` | Main website |
| `[app.yourproject.io]` | App / dApp |
| `[docs.yourproject.io]` | Documentation |
| `[blog.yourproject.io]` | Blog |
| [add all subdomains] | |

---

## Typosquat Patterns to Check

<!--
  The agent generates these variants and checks them via WHOIS + Google Safe Browsing.
  List base patterns — agent applies standard substitutions automatically.
-->

**Base domain**: `[yourproject.io]`

**High-risk TLD variants to check:**
- `[yourproject].com`
- `[yourproject].net`
- `[yourproject].org`
- `[yourproject].co`
- `[yourproject].xyz`
- `[yourproject]-airdrop.com`
- `[yourproject]-claim.com`
- `[yourproject]-official.com`
- `[yourproject]app.io`

**Character substitution domains to check:**
- `[y0urproject].io` (0 for o)
- `[yovrproject].io` (v for u)
- `[yourproiect].io` (i for j)

---

## Known Malicious Domains (Already Confirmed)

<!--
  Add domains confirmed as phishing/scam. These get score 3 automatic.
  Format: domain | date discovered | type
-->

| Domain | Date Discovered | Type | Status |
|--------|----------------|------|--------|
| [example-scam.com] | [YYYY-MM-DD] | Fake airdrop | Reported |

---

## Phishing Indicator Keywords

<!--
  When scanning for fake pages/sites, flag pages mentioning your project alongside these keywords.
  The agent uses these in combination with project name searches.
-->

- `airdrop` + `[PROJECT NAME]`
- `claim` + `[TOKEN SYMBOL]`
- `giveaway` + `[PROJECT NAME]`
- `presale` + `[PROJECT NAME]` (unless it's officially announced)
- `connect wallet` + `[PROJECT NAME]` (on any non-official domain)

---

## Scoring Rules for phishing_scan()

| Finding | Score |
|---------|-------|
| Domain on Google Safe Browsing SOCIAL_ENGINEERING list | 3 |
| Domain registered <30 days ago AND closely matches official domain | 3 |
| Domain registered <90 days ago AND similar to official domain | 2 |
| Domain with project name + airdrop/claim/giveaway keyword | 2 |
| Domain similar to official but registered >6 months ago (likely benign) | 1 |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
