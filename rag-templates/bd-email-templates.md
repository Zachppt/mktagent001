# Email Templates
<!--
  Used by BD Agent: cold_email_writer()
  One template per outreach type. Each has:
  - Subject line variants (A/B)
  - Body with {{PERSONALIZATION}} slots
  
  Keep bodies under 200 words. Goal = a reply, not a sale.
  Delete these comment blocks before deploying.
-->

---

## EXCHANGE

**Subject A**: `[YOUR_PROJECT] x [EXCHANGE] — listing conversation`
**Subject B**: `[TOKEN_SYMBOL] listing — 5 min to talk?`

**Body**:
```
Hi [FIRST_NAME],

{{PERSONALIZATION: reference one recent listing they announced or a chain they've expanded to}}

[YOUR_PROJECT] is [ONE_LINE_DESCRIPTION]. We're live on [CHAIN] with [KEY_METRIC — e.g. "2,400 active nodes" or "$12M TVL"].

Given your expansion into [ECOSYSTEM], we think there's a strong fit. Happy to share full stats + our listing package if useful.

Worth a 15-minute call?

[YOUR_NAME]
[YOUR_TITLE] — [YOUR_PROJECT]
```

---

## PROTOCOL_PARTNER

**Subject A**: `[YOUR_PROJECT] + [THEIR_PROJECT] — integration idea`
**Subject B**: `Quick thought on [THEIR_PROJECT] x [YOUR_PROJECT]`

**Body**:
```
Hi [FIRST_NAME],

{{PERSONALIZATION: reference a specific feature, tweet, or roadmap item from their project}}

One thing caught my attention: [SPECIFIC_OBSERVATION]. We've been thinking about a similar problem from the [YOUR_ANGLE] side.

[YOUR_PROJECT] [ONE_LINE_DESCRIPTION]. An integration with [THEIR_PROJECT] could [SPECIFIC_VALUE_TO_THEM — be concrete].

Would it make sense to explore? Happy to sketch out a quick integration spec first to see if the tech fits.

[YOUR_NAME]
```

---

## INVESTOR

**Subject A**: `[YOUR_PROJECT] — [ROUND] round, quick intro`
**Subject B**: `[TOKEN_SYMBOL] — [METRIC] traction, raising [ROUND]`

**Body**:
```
Hi [FIRST_NAME],

{{PERSONALIZATION: reference a portfolio company of theirs or a thesis tweet they published}}

[YOUR_PROJECT] is [ONE_LINE_DESCRIPTION]. Numbers since launch:
- [METRIC 1]: [VALUE]
- [METRIC 2]: [VALUE]
- [METRIC 3]: [VALUE]

We're raising [AMOUNT] at [TERMS OR "terms TBD"]. [LEAD_INVESTOR or "Seeking lead"] with close targeted for [TIMEFRAME].

Given your focus on [THEIR_THESIS], thought it was worth a note. Deck available if helpful.

[YOUR_NAME]
```

---

## KOL

**Subject A**: `[YOUR_PROJECT] x [THEIR_HANDLE] — paid collab idea`
**Subject B**: `Thought you'd find this interesting — [TOPIC]`

**Body**:
```
Hi [FIRST_NAME],

{{PERSONALIZATION: reference a specific post/thread of theirs that aligns with your thesis}}

Your take on [THEIR_TOPIC] resonated — [YOUR_PROJECT] is building exactly in that direction.

[ONE_LINE_PROJECT_DESCRIPTION]. We're working with a few voices in the [VERTICAL] space and thought of you specifically for [SPECIFIC_CONTENT_IDEA].

Open to discussing a collab? Happy to share more details on our community and what we're working on.

[YOUR_NAME]
```

---

## ECOSYSTEM

**Subject A**: `[YOUR_PROJECT] for the [ECOSYSTEM] ecosystem`
**Subject B**: `[YOUR_PROJECT] — [ECOSYSTEM] native, worth a look`

**Body**:
```
Hi [FIRST_NAME],

{{PERSONALIZATION: reference a recent ecosystem initiative, grant program, or developer update}}

[YOUR_PROJECT] is a [YOUR_CATEGORY] project live on [CHAIN/ECOSYSTEM]. [ONE_LINE_DESCRIPTION].

We'd love to be part of [THEIR_ECOSYSTEM_PROGRAM OR developer community]. [SPECIFIC_ASK — e.g. "Interested in your grants program" or "Happy to present at your next builder call"].

Would you be the right person to connect with, or should I reach out to someone else on the team?

[YOUR_NAME]
```

---

## FOLLOW-UP (use after 7 days of no reply)

**Subject**: `Re: [ORIGINAL_SUBJECT]`

**Body**:
```
Hi [FIRST_NAME],

Wanted to follow up on my note from [DATE].

[ONE NEW DATA POINT OR UPDATE since last email — e.g. "We just crossed 3,000 active nodes" or "We announced our Series A this week"]

Still think there's something worth exploring. Worth 15 minutes?

[YOUR_NAME]
```

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
