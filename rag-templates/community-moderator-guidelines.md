# Moderator Guidelines
<!--
  Used by Community Agent: auto_reply() escalation logic and community_update()
  Defines rules, escalation paths, and moderation criteria.
  Delete these comment blocks before deploying.
-->

## Community Rules (post in Discord/TG)

1. Be respectful — no harassment, hate speech, or personal attacks
2. No price discussion, financial advice, or "will it moon" posts
3. No spam, repeated messages, or unsolicited DMs
4. No sharing of unofficial links or unverified contract addresses
5. No impersonation of team members or moderators
6. No promotion of other projects without prior approval
7. English only in main channels (dedicated language channels if applicable)
8. [Add project-specific rules]

---

## Moderation Actions

### Warning
**Trigger**: First-time rule violation, accidental
**Action**: Public or private message explaining the rule
**Community Agent**: Can issue — send a reply citing the rule

### Mute (Timeout)
**Trigger**: Repeated rule violations, spam, FUD spreading
**Duration**: [e.g. 1 hour for first offense, 24 hours for second]
**Action**: Mute via Discord timeout or Telegram restrict
**Community Agent**: Can execute if bot has manage_messages permission; log to memory

### Kick
**Trigger**: Severe violation, persistent rule-breaking after mutes
**Action**: Remove from server/group, can rejoin
**Community Agent**: Escalate to human moderator — HUMAN_REQUIRED

### Ban
**Trigger**: Scam attempt, doxxing, coordinated attack, extreme harassment
**Action**: Permanent removal
**Community Agent**: Escalate to PM Agent immediately — HUMAN_REQUIRED

---

## Escalation Paths

| Situation | Community Agent Action | Escalate To |
|-----------|----------------------|------------|
| Price/investment question | Auto-reply with deflection | Log only |
| Technical question beyond FAQ | Reply + escalate | Human moderator via PM Agent |
| Scam link posted | Flag + delete if possible | PM Agent immediately |
| Team impersonation in DMs reported | Log + warn community | PM Agent + Security Agent |
| Coordinated FUD attack | Trigger crisis_draft() | PM Agent + HUMAN_REQUIRED |
| User reports fund loss | Acknowledge + escalate | PM Agent + HUMAN_REQUIRED |

---

## Human Moderator Contacts

| Role | Discord Handle | Telegram | Available |
|------|--------------|---------|-----------|
| Lead Mod | [handle] | [handle] | [hours] |
| Backup Mod | [handle] | [handle] | [hours] |
| Team contact | [handle] | [handle] | Weekdays |

---

## Off-Hours Protocol

When no human moderator is online:
- Community Agent handles FAQ auto-replies as normal
- If crisis detected: crisis_draft() fires immediately, PM Agent DMs operator
- Mutes can be applied by bot; kicks and bans wait for human
- Major announcements: hold until human moderator is available

---

## Content That Is Always Banned

- Contract addresses other than official ones (automatic delete + ban)
- "Wallet drainer" or airdrop scam links (automatic delete + ban)
- Explicit or violent content
- Doxxing (personal information) of any community member or team member

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
