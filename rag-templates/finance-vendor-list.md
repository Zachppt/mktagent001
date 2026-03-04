# Vendor List
<!--
  Used by Finance Agent: invoice_log()
  Any vendor not on this list triggers a flag before invoice is logged.
  Keep this up to date as you add new service providers.
  Delete these comment blocks before deploying.
-->

## Approved Vendors

### SaaS / Tools

| Vendor Name | Category | Monthly Cost | Billing Date | Contact |
|------------|---------|-------------|-------------|---------|
| [e.g. Apollo.io] | BD Tools | $[amount] | [day of month] | [email] |
| [e.g. SerpAPI] | SEO | $[amount] | [day of month] | [email] |
| [e.g. Figma] | Design | $[amount] | [day of month] | [email] |
| [e.g. Notion] | Ops | $[amount] | [day of month] | [email] |
| [Add more] | | | | |

### Agencies / Freelancers

| Vendor Name | Category | Contract Type | Rate | Contract Expiry |
|------------|---------|--------------|------|----------------|
| [e.g. Designer Name] | Design | Monthly retainer | $[amount] | [date] |
| [e.g. Video Studio] | Video | Per project | $[amount]/video | [date] |
| [Add more] | | | | |

### KOL / Influencers

| Handle | Platform | Deal Type | Rate | Deal Period |
|--------|---------|----------|------|------------|
| @[handle] | Twitter | [per post / retainer] | $[amount] | [start–end] |
| [Add more] | | | | |

### Ad Platforms

| Platform | Category | Billing Method | Account Manager |
|---------|---------|---------------|----------------|
| Twitter Ads | Paid Social | Auto-charge on spend | [email if applicable] |
| [Add more] | | | |

---

## Vendor Approval Process

New vendors not on this list:
1. Finance Agent flags the invoice
2. PM Agent notifies operator
3. Operator adds to this list before invoice is logged
4. Finance Agent re-processes invoice

---

## Payment Terms Reference

| Vendor Type | Standard Terms |
|------------|---------------|
| SaaS subscriptions | Auto-renew — check contract_monitor() |
| Agencies | Net 30 unless stated otherwise |
| Freelancers | On delivery or milestone |
| KOLs | 50% upfront, 50% on delivery (suggested) |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
