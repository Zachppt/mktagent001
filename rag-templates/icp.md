# Ideal Customer Profile (ICP)
<!--
  INSTRUCTIONS:
  Used by BD Agent for prospect_search() and cold_email_writer().
  Define exactly who you want to partner with or sell to.
  The more specific, the better the lead quality.
  Delete these comment blocks before deploying.
-->

## Who We Target

### Primary ICP — [Target Type 1, e.g. "Crypto Exchanges"]
- **Why they need us**: [e.g. "They need reliable infrastructure to support trading volume"]
- **Company size**: [e.g. "Top 50 by trading volume"]
- **Geography**: [e.g. "Global — prioritize Asia and EU"]
- **Key decision maker role**: [e.g. "VP of Business Development, Head of Listings"]
- **Signals that indicate readiness**: [e.g. "Recently listed 3+ DePIN tokens", "Hiring for Web3 partnerships"]
- **Email type to use**: `EXCHANGE`

### Secondary ICP — [Target Type 2, e.g. "Protocol Partners"]
- **Why they need us**: [e.g. "Composability — integrate our compute layer into their dApp"]
- **Company size**: [e.g. "TVL > $10M or 10k+ active users"]
- **Geography**: [e.g. "Any — English-speaking first"]
- **Key decision maker role**: [e.g. "CTO, Head of Ecosystem"]
- **Signals that indicate readiness**: [e.g. "Building AI/compute-adjacent features", "Posted about infrastructure needs"]
- **Email type to use**: `PROTOCOL_PARTNER`

### Tertiary ICP — [Target Type 3, e.g. "KOLs / Influencers"]
- **Why they need us**: [e.g. "Content about real infrastructure resonates with their audience"]
- **Follower range**: [e.g. "50k–500k Twitter, crypto-native audience"]
- **Content style**: [e.g. "Technical deep-dives or ecosystem analysis — not pure price content"]
- **Email type to use**: `KOL`

---

## Disqualifiers

<!-- Prospects that should be filtered OUT regardless of other signals -->
- [e.g. "Projects primarily focused on meme coins or speculation"]
- [e.g. "Companies under regulatory investigation"]
- [e.g. "Competitors on the competitor-intel.md list"]
- [add more]

---

## Prospecting Sources

<!-- Where BD Agent searches for leads -->
- Apollo.io (primary — configure filters below)
- Twitter/X (search by bio keywords + recent activity)
- [Other sources you use]

### Apollo.io Filter Configuration
```
Industry:     [e.g. "Blockchain / Cryptocurrency"]
Company size: [e.g. "11-500 employees"]
Keywords:     [e.g. "DeFi", "Web3", "Layer 2", "infrastructure"]
Location:     [e.g. "United States, Singapore, United Kingdom, Germany"]
Job title keywords: [e.g. "Partnership", "BD", "Business Development", "Ecosystem"]
```

---

## Lead Scoring Criteria (1–5)

| Score | Criteria |
|-------|----------|
| 5 | Matches primary ICP exactly + recent positive signal |
| 4 | Matches primary ICP + minor gaps |
| 3 | Matches secondary ICP well |
| 2 | Adjacent — possible fit but not obvious |
| 1 | Weak fit — do not contact |

**BD Agent contacts score ≥ 3 only.**

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
