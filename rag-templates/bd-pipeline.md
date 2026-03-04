# BD Pipeline
<!--
  INSTRUCTIONS:
  This file is READ and WRITTEN by BD Agent automatically.
  - prospect_search() writes new leads here (score ≥ 3)
  - cold_email_writer() reads leads and updates status
  - You can also add leads manually using the format below

  Statuses:
    NEW        → found by prospect_search(), not yet contacted
    DRAFTED    → email drafted, awaiting human approval
    SENT       → email sent
    REPLIED    → response received
    MEETING    → call/meeting booked
    CLOSED     → deal done
    REJECTED   → not a fit, do not re-contact

  Delete these comment blocks before deploying.
-->

## Active Pipeline

<!-- BD Agent appends new prospects here automatically -->

| ID | Name / Company | Type | Contact | Score | Status | Last Action | Notes |
|----|---------------|------|---------|-------|--------|------------|-------|
| — | — | — | — | — | — | — | — |

---

## Closed / Archived

<!-- Deals that closed (won or lost) are moved here -->

| ID | Name / Company | Type | Outcome | Date | Notes |
|----|---------------|------|---------|------|-------|
| — | — | — | — | — | — |

---

## Do Not Contact List

<!-- Accounts that have declined or should never be contacted -->

| Handle / Company | Reason | Date Added |
|-----------------|--------|-----------|
| — | — | — |

---

## Pipeline Stats

<!-- Updated by Data Agent in weekly report -->

| Metric | This Week | Last Week |
|--------|-----------|-----------|
| New prospects | — | — |
| Emails sent | — | — |
| Replies received | — | — |
| Reply rate | — | — |
| Meetings booked | — | — |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | File initialized — pipeline empty |
