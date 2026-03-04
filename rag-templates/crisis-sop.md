# Crisis SOP
<!--
  INSTRUCTIONS:
  This file is loaded by PM Agent during any crisis or community emergency.
  Be specific — vague playbooks produce vague responses at the worst time.
  
  A "crisis" is any event that could damage project reputation or community trust:
  - Security incident / exploit
  - Smart contract bug
  - Team member controversy
  - Negative media coverage
  - Community FUD spiral
  - Exchange delisting / regulatory action
  
  Delete these comment blocks before deploying.
-->

## Crisis Levels

| Level | Description | Response Time | Who Acts |
|-------|-------------|--------------|---------|
| L1 — Watch | Negative sentiment rising, not yet viral | 2 hours | Community Agent monitors |
| L2 — Active | FUD spreading, community asking questions | 30 minutes | PM Agent + human operator |
| L3 — Critical | Exploit, major negative news, viral attack | Immediate | Human operator leads, all agents support |

---

## L1 Response (Watch)

PM Agent action:
1. Notify operator via Slack DM with sentiment data
2. Draft holding statement (do not publish yet)
3. Monitor for escalation every 15 minutes
4. If sentiment drops further: escalate to L2

Holding statement template:
> "We're aware of the conversation happening around [topic]. Our team is reviewing. We'll share a full update within [X hours]."

---

## L2 Response (Active)

PM Agent action:
1. Escalate to operator immediately (HUMAN_REQUIRED)
2. Prepare 3 response options:
   - Option A: Full transparency statement
   - Option B: Holding statement + timeline commitment
   - Option C: No comment (use only if legal situation requires)
3. Draft FAQ responses for Community Agent
4. Pause all scheduled Social Agent posts until cleared

Operator must approve all L2 communications before publish.

---

## L3 Response (Critical)

All agent actions pause. Human operator leads.

PM Agent support role:
1. Draft initial community statement for operator review
2. Prepare FAQ for Community Agent (Discord/TG)
3. Log all published statements with timestamps
4. Monitor sentiment every 5 minutes and report to operator

**Do not publish anything at L3 without explicit operator approval.**

---

## Key Contacts

<!--
  Fill in your escalation contacts. These are referenced by PM Agent when notifying humans.
-->

| Role | Contact | Channel |
|------|---------|---------|
| Project Lead | [name] | [Telegram / Signal / Email] |
| Tech Lead | [name] | [contact] |
| Legal | [name or "TBD"] | [contact] |
| PR / Comms | [name or "TBD"] | [contact] |

---

## Post-Crisis

After any L2 or L3 event:
1. PM Agent writes full incident log to memory
2. Retrospective brief prepared for operator (what happened, what was communicated, what to improve)
3. Update this SOP if gaps were identified

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
