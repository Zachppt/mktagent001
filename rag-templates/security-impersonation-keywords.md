# Impersonation Keywords
<!--
  Used by Security Agent: impersonation_scan()
  List every variation of your project name, token, and team handles
  that an impersonator might use. Be thorough — impersonators are creative.
  Delete these comment blocks before deploying.
-->

## Official Accounts (Whitelist — do NOT flag these)

| Platform | Handle | Notes |
|---------|--------|-------|
| Twitter/X | @[YOUR_OFFICIAL_HANDLE] | Main project account |
| Twitter/X | @[FOUNDER_HANDLE] | Founder |
| Twitter/X | @[CTO_HANDLE] | CTO |
| [Add all official team handles] | | |

---

## Project Name Variants to Monitor

<!--
  For a project named "Aethir", you'd list:
  Aethir2, AethirOfficial, Aethir_Official, AethirSupport, Aethir_Support, etc.
-->

### Exact name + common suffixes
- `[PROJECT_NAME]2`
- `[PROJECT_NAME]_Official`
- `[PROJECT_NAME]Official`
- `[PROJECT_NAME]_Support`
- `[PROJECT_NAME]Support`
- `[PROJECT_NAME]_Airdrop`
- `[PROJECT_NAME]Airdrop`
- `[PROJECT_NAME]_CEO`
- `[PROJECT_NAME]_Team`
- `Real[PROJECT_NAME]`
- `The[PROJECT_NAME]`
- `[PROJECT_NAME]HQ`

### Token symbol variants
- `[TOKEN_SYMBOL]_Airdrop`
- `[TOKEN_SYMBOL]Official`
- `[TOKEN_SYMBOL]Token`
- `[TOKEN_SYMBOL]_Official`
- `Free[TOKEN_SYMBOL]`

### Team handle variants
<!-- For each key team member, add their handle + common impersonation patterns -->
- `[FOUNDER_HANDLE]_`  (underscore appended)
- `[FOUNDER_HANDLE]2`
- `Real[FOUNDER_HANDLE]`

---

## Suspicious Behavior Patterns (score +1 each)

An account matching a keyword variant gets a higher score if it also:
- Account age < 30 days
- Follower count > 1,000 (suspicious for new account)
- Bio contains "official", "airdrop", "support", "DM for help"
- Recent tweets contain links to non-official domains
- Pinned post contains wallet address or "claim" link

Score 3 auto-triggers on:
- Any account posting our official contract address AND claiming to be official
- Any account DMing users with airdrop/giveaway claims using our brand

---

## Official Domains (for phishing comparison)

| Domain | Use |
|--------|-----|
| [yourproject.io] | Main website |
| [docs.yourproject.io] | Documentation |
| [app.yourproject.io] | Application |
| [Add all official subdomains] | |

---

## Known False Positives

<!-- Accounts that match patterns but are NOT impersonators — skip these -->
| Handle | Reason |
|--------|--------|
| @[handle] | [e.g. Legitimate community account, not official] |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
