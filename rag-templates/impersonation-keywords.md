# Impersonation Keywords
<!--
  INSTRUCTIONS:
  Used by Security Agent impersonation_scan() every 6 hours.
  List every variant of your project's name, token, and founder handles
  that scammers might use to impersonate you.
  
  Be thorough — scammers are creative with character substitutions.
  Delete these comment blocks before deploying.
-->

## Official Accounts (Whitelist — never flag these)

| Platform | Handle | URL |
|----------|--------|-----|
| Twitter/X (main) | `@[YOUR_OFFICIAL_HANDLE]` | https://twitter.com/[handle] |
| Twitter/X (ecosystem) | `@[YOUR_ECO_HANDLE]` | https://twitter.com/[handle] |
| Telegram (main) | `@[YOUR_TG_HANDLE]` | — |
| [add all official accounts] | | |

---

## Project Name Variants to Monitor

<!--
  Add common suffix patterns scammers append to your project name.
  The agent searches Twitter/X for accounts containing these strings.
-->

**Base name**: `[YOUR PROJECT NAME]`

**High-risk variants (search these):**
- `[ProjectName]Official`
- `[ProjectName]_Real`
- `[ProjectName]Support`
- `[ProjectName]Airdrop`
- `[ProjectName]Giveaway`
- `[ProjectName]HQ`
- `[ProjectName]CEO`
- `[ProjectName]Team`
- `Real[ProjectName]`
- `Official[ProjectName]`
- `[ProjectName]io` (without the dot)
- `[ProjectName]App`

**Character substitution patterns (common scammer tricks):**
- Replace `O` with `0`: `[Project0fficial]`
- Replace `l` with `1`: `[Project1]`
- Add extra letters: `[Projectt]`, `[PProjectName]`
- Use Unicode lookalikes: `Р` (Cyrillic) instead of `P`

---

## Token Symbol Variants to Monitor

**Token symbol**: `[TOKEN_SYMBOL]`

**Search patterns:**
- `[TOKEN]Airdrop`
- `[TOKEN]Giveaway`
- `[TOKEN]Claim`
- `Free[TOKEN]`
- `[TOKEN]Official`

---

## Founder / Team Handle Variants to Monitor

<!--
  List core team members whose impersonation would be most damaging.
  Usually CEO, CTO, and any well-known team members.
-->

| Real Handle | Risk Level | Variants to Monitor |
|------------|-----------|---------------------|
| `@[FOUNDER_1]` | HIGH | `@[founder1]_`, `@real[founder1]`, `@[founder1]official` |
| `@[FOUNDER_2]` | HIGH | [variants] |
| [add team members] | | |

---

## Scoring Rules for impersonation_scan()

| Finding | Score |
|---------|-------|
| Account name matches variant AND has <1k followers AND account <30 days old | 3 |
| Account name matches variant AND is posting airdrop/giveaway content | 3 |
| Account name matches variant AND has Telegram/URL in bio | 2 |
| Account name matches variant (no other signals) | 1 |
| Official account in whitelist | 0 (ignore) |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
