# Event Targets
<!--
  Used by BD Agent: event_scout()
  List conferences, hackathons, and meetups worth attending, speaking at, or sponsoring.
  Agent scans for these events weekly and surfaces upcoming ones within 60 days.
  Delete these comment blocks before deploying.
-->

## Priority Events (Always Track)

| Event | Type | Typical Timing | Why |
|-------|------|---------------|-----|
| [e.g. ETHDenver] | Hackathon + Conference | Feb | [e.g. Largest Ethereum developer event, 15k+ attendees] |
| [e.g. Consensus] | Conference | May | [e.g. Institutional + media presence, good for BD] |
| [e.g. TOKEN2049] | Conference | Sep/Apr | [e.g. Asia-Pacific market, VCs and exchanges] |
| [e.g. Devcon] | Developer Conference | Annual | [e.g. Core Ethereum builders, technical credibility] |
| [Add more] | | | |

---

## Secondary Events (Track If Relevant)

| Event | Type | Typical Timing | Relevance |
|-------|------|---------------|-----------|
| [e.g. EthCC] | Conference | Jul | [e.g. European ecosystem] |
| [e.g. Breakpoint] | Solana Conference | Annual | [e.g. If targeting Solana ecosystem] |
| [Add more] | | | |

---

## Engagement Types We Target

- [ ] **Speaking slot** — our team on stage
- [ ] **Sponsor booth** — brand presence + lead gen
- [ ] **Side event** — host or co-host our own gathering
- [ ] **Hackathon bounty** — developer acquisition
- [ ] **Attend only** — networking, no spend required

---

## Scoring Criteria for event_scout()

Agent uses these criteria when scoring new events found in search:

| Criteria | Score Weight |
|---------|-------------|
| Audience > 1,000 | +2 |
| Our target ecosystem (e.g. EVM, DePIN, AI) | +2 |
| Application deadline > 14 days away | +1 |
| Speaking/sponsorship opportunity | +1 |
| Total ≥ 4 → flag to PM Agent | |

---

## Blacklist (never attend or sponsor)

- [e.g. Events associated with known scam projects]
- [e.g. Events that have previously hosted misleading panels]

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
