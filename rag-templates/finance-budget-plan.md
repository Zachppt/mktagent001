# Budget Plan
<!--
  Used by Finance Agent: budget_tracker() and budget_report()
  Set your monthly marketing budget allocation by category.
  Agent compares actual spend vs these numbers daily.
  Delete these comment blocks before deploying.
-->

## Monthly Budget Allocation

**Total Monthly Marketing Budget**: $[TOTAL]
**Budget Period**: [e.g. "Calendar month" or "Rolling 30 days"]
**Currency**: [USD / USDT / other]

---

## Category Breakdown

| Category | Monthly Budget | Notes |
|---------|---------------|-------|
| Social Media Ads | $[AMOUNT] | [e.g. Twitter/X promoted tweets] |
| KOL / Influencer | $[AMOUNT] | [e.g. Paid content collaborations] |
| Content Production | $[AMOUNT] | [e.g. Design, video, copywriting freelancers] |
| PR / Media | $[AMOUNT] | [e.g. Press releases, media partnerships] |
| Events / Sponsorships | $[AMOUNT] | [e.g. Conference booths, hackathon bounties] |
| Tools & Subscriptions | $[AMOUNT] | [e.g. Apollo.io, SerpAPI, design tools] |
| Community Incentives | $[AMOUNT] | [e.g. Discord rewards, contest prizes] |
| Reserve / Contingency | $[AMOUNT] | [e.g. 10% of total for opportunistic spend] |
| **Total** | **$[TOTAL]** | |

---

## Alert Thresholds

| Level | Trigger | Action |
|-------|---------|--------|
| Warning | 80% of any category consumed | 🟡 SLACK_REVIEW notification |
| Critical | 95% of any category consumed | 🔴 HUMAN_REQUIRED — halt further spend |
| Overspend | Projected month-end > 105% of budget | 🟡 SLACK_REVIEW warning |

---

## Approved Vendors by Category

<!-- Finance Agent checks new invoices against vendor-list.md separately -->
<!-- This section is for budget owner reference only -->

- **Social Ads**: [e.g. Twitter Ads Manager — direct billing]
- **KOL**: [e.g. individual agreements per deal]
- **Tools**: [list key SaaS subscriptions]

---

## Annual Planning Notes

- Q1 focus: [e.g. "Community growth — weight toward incentives"]
- Q2 focus: [e.g. "Exchange BD — weight toward events"]
- Q3 focus: [e.g. "Content and SEO — weight toward production"]
- Q4 focus: [e.g. "Partnerships — weight toward PR and events"]

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
