# Routing Rules
<!--
  INSTRUCTIONS:
  Used by PM Agent: dispatch_task() → intent_classifier()
  This file defines how inbound messages are routed to agents.
  Fill in your project-specific keywords to improve routing accuracy.
  Delete these comment blocks before deploying.
-->

## Intent Classification Rules

PM Agent reads this file on every inbound message to determine which agent handles the task.

### SOCIAL
Route to Social Agent when the message involves:
- Twitter/X posts, threads, or replies
- LinkedIn posts or articles
- Meme creation or templates
- Trend monitoring or Twitter analytics
- Social media scheduling
- Keywords: `tweet`, `post`, `linkedin`, `meme`, `trend`, `social`, `thread`, `viral`

### CONTENT
Route to Content Agent when the message involves:
- Blog posts, articles, or long-form writing
- Video scripts or podcast outlines
- Design briefs or banner copy
- SEO-optimized content
- Content calendar planning
- Keywords: `blog`, `article`, `write`, `script`, `content`, `copy`, `banner`, `newsletter`

### DATA
Route to Data Agent when the message involves:
- Token price monitoring or alerts
- Competitor analysis or tracking
- Analytics reports (social, SEO, on-chain)
- Keyword ranking checks
- Market data or metrics
- Keywords: `analytics`, `data`, `metrics`, `price`, `competitor`, `ranking`, `report`, `monitor`

### BD
Route to BD Agent when the message involves:
- Finding partnership or exchange leads
- Drafting outreach or cold emails
- BD pipeline updates
- Event scouting for conferences or hackathons
- Keywords: `partnership`, `bd`, `outreach`, `email`, `lead`, `prospect`, `exchange`, `listing`, `proposal`

### COMMUNITY
Route to Community Agent when the message involves:
- Discord or Telegram moderation
- Community sentiment analysis
- FAQ responses
- Crisis communication drafts
- Community announcements
- Keywords: `community`, `discord`, `telegram`, `sentiment`, `fud`, `moderation`, `announcement`, `crisis`

### ECO
Route to Eco Agent when the message involves:
- Ecosystem partnership prospecting
- Event announcements (hackathons, conferences)
- Brand analysis vs ecosystem projects
- Grant program outreach
- Keywords: `ecosystem`, `grant`, `hackathon`, `event`, `sponsor`, `partner`, `protocol`

### FINANCE
Route to Finance Agent when the message involves:
- Invoice logging or approval
- Budget tracking or reports
- Vendor management
- Marketing spend analysis
- Keywords: `invoice`, `budget`, `vendor`, `payment`, `spend`, `finance`, `cost`, `contract`

### SECURITY
Route to Security Agent when the message involves:
- Impersonation reports or scans
- Phishing link reports
- API key audit requests
- Security alerts or suspicious activity
- Keywords: `impersonation`, `phishing`, `scam`, `hack`, `security`, `suspicious`, `fake`, `audit`

### UNCLEAR
If no clear intent matches → ask operator one clarifying question.
Never default to AUTO execution when intent is ambiguous.

---

## Approval Tier Defaults by Intent

| Intent | Default Tier | Override Conditions |
|--------|-------------|-------------------|
| SOCIAL | 🟡 SLACK_REVIEW | Pure monitoring tasks → AUTO |
| CONTENT | 🟡 SLACK_REVIEW | Internal drafts → AUTO |
| DATA | 🟢 AUTO | Any outbound report → SLACK_REVIEW |
| BD | 🟡 SLACK_REVIEW | Any email send → 🔴 HUMAN_REQUIRED |
| COMMUNITY | 🟡 SLACK_REVIEW | Crisis L3 → 🔴 HUMAN_REQUIRED |
| ECO | 🟡 SLACK_REVIEW | Any outbound email → 🔴 HUMAN_REQUIRED |
| FINANCE | 🔴 HUMAN_REQUIRED | Read-only queries → AUTO |
| SECURITY | 🟢 AUTO | Takedown requests → 🔴 HUMAN_REQUIRED |

---

## Project-Specific Keywords

<!-- Add keywords unique to your project that help classify intent -->
<!-- Example for a DePIN project:
  - "node", "GPU", "compute" → DATA or CONTENT depending on context
  - "operator" → COMMUNITY
  - "node sale" → SOCIAL + COMMUNITY
-->

- `[add your token symbol]` → DATA (price monitoring)
- `[add your project name]` → DATA or CONTENT depending on context
- `[add more]`

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
