# Ideal Customer Profile (ICP)
<!--
  Used by BD Agent: prospect_search() and cold_email_writer()
  Define exactly who you want to reach. The more specific, the better the leads.
  Delete these comment blocks before deploying.
-->

## Primary Target: [TYPE 1 — e.g. "Centralized Exchanges"]

**Why they matter**: [e.g. "Listing = price discovery + liquidity + credibility signal"]

### Company Criteria
- **Type**: [e.g. CEX / DEX / Launchpad / VC / Protocol]
- **Size**: [e.g. Top 50 by volume, or $10M+ TVL]
- **Geography**: [e.g. Global, or Asia-focused]
- **Ecosystem**: [e.g. EVM-compatible, Solana ecosystem]

### Contact Criteria
- **Target roles**: [e.g. "Head of Listings", "BD Lead", "Partnerships Manager"]
- **Avoid**: [e.g. "Marketing interns, junior analysts"]

### Personalization Hooks
- [e.g. "Reference their recent listing of similar projects"]
- [e.g. "Mention shared investor overlap if applicable"]
- [e.g. "Reference their active ecosystem grant program"]

### Email Type
- Use template: `EXCHANGE` from `rag/email-templates.md`

---

## Secondary Target: [TYPE 2 — e.g. "Protocol Partners"]

**Why they matter**: [e.g. "Integration = TVL growth + shared community"]

### Company Criteria
- **Type**: [e.g. DeFi protocol, L2 network, data provider]
- **Size**: [e.g. $50M+ TVL, or 10k+ active users]
- **Complementary**: [e.g. "Needs compute layer we provide; we need their user base"]

### Contact Criteria
- **Target roles**: [e.g. "CTO", "Head of Integrations", "Ecosystem Lead"]

### Personalization Hooks
- [e.g. "Reference their recent roadmap announcement"]
- [e.g. "Mention how our tech solves a specific problem they've tweeted about"]

### Email Type
- Use template: `PROTOCOL_PARTNER` from `rag/email-templates.md`

---

## Target: [TYPE 3 — e.g. "KOLs / Influencers"]

**Why they matter**: [e.g. "Distribution to targeted audiences, faster than organic growth"]

### Profile Criteria
- **Follower range**: [e.g. 10k–500k Twitter followers]
- **Engagement rate**: [e.g. > 2% (avoid inflated accounts)]
- **Audience**: [e.g. Technical crypto Twitter, DePIN-specific, AI x crypto]
- **Avoid**: [e.g. Accounts with history of paid pump schemes]

### Contact Criteria
- **Contact via**: [e.g. Twitter DM first, then email if no response]

### Personalization Hooks
- [e.g. "Reference a specific tweet of theirs that aligns with our thesis"]

### Email Type
- Use template: `KOL` from `rag/email-templates.md`

---

## Disqualifiers (never contact)

- [e.g. "Competitors or projects in direct conflict with our model"]
- [e.g. "Projects involved in regulatory action in the last 12 months"]
- [e.g. "Contacts who have previously declined outreach — check bd-pipeline.md"]

---

## Pipeline Score Guide

Used by `prospect_search()` to score Apollo.io results:

| Score | Criteria |
|-------|---------|
| 5 | Perfect ICP match, active in ecosystem, high personalization opportunity |
| 4 | Strong match, proceed to email draft |
| 3 | Decent match, add to pipeline for future outreach |
| 2 | Weak match, monitor only |
| 1 | Disqualifier hit, reject |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
