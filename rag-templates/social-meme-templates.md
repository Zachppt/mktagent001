# Meme Templates
<!--
  Used by Social Agent: meme_trigger()
  List approved meme formats your community recognizes.
  For each template, describe the format and provide copy patterns.
  Agent generates copy — humans (or design tool) produce the final image.
  Delete these comment blocks before deploying.
-->

## Template 1: Drake Pointing / Drake Approving

**Format**: Drake disapproves top panel / Drake approves bottom panel
**Best for**: Comparing old way vs new way; competitor weakness vs our strength
**Community reception**: [e.g. "Well-known, always works if copy is sharp"]

**Copy pattern**:
```
Top (disapproves): [Old/inferior approach or competitor behavior]
Bottom (approves): [Your project's approach or benefit]
```

**Example**:
```
Top: Paying $500/hr for centralized GPU cloud compute
Bottom: Renting idle GPUs from a global decentralized network
```

---

## Template 2: "This is fine" Dog (burning room)

**Format**: Dog sitting in burning room saying "This is fine"
**Best for**: Ironic commentary on market conditions, FUD moments, or industry problems your project solves

**Copy pattern**:
```
Caption: [The ironic situation — what others are ignoring]
Post copy: [Subtext — what your project is doing about it]
```

---

## Template 3: Expanding Brain

**Format**: 4-panel brain expanding meme
**Best for**: Showing progression from simple to sophisticated thinking about a concept

**Copy pattern**:
```
Panel 1 (small brain): [Simplest/laziest take]
Panel 2 (normal brain): [Average take]
Panel 3 (big brain): [Smart take]
Panel 4 (galaxy brain): [Your project's / community's take]
```

---

## Template 4: "They're the same picture" (The Office)

**Format**: Pam holding two photos saying "They're the same picture"
**Best for**: Pointing out similarities between two things (competitor comparison, market convergence)

**Copy pattern**:
```
Photo 1: [Thing A]
Photo 2: [Thing B that is functionally the same]
```

---

## Template 5: Custom / Project-Specific

**Format**: [Describe any meme formats specific to your community or ecosystem]
**Best for**: [When to use]
**Copy pattern**: [Template]

---

## Meme Guidelines

**Always**:
- Credit template source if it's a well-known format
- Keep copy under 10 words per panel
- Self-aware > punching down — the project can be in on the joke

**Never**:
- Mock or directly reference competitor projects by name
- Use memes referencing sensitive current events (deaths, disasters)
- Use templates with offensive origins
- Post without SLACK_REVIEW approval

---

## Trend Scoring for meme_trigger()

When `trending_scan()` returns score ≥ 4, Social Agent selects a template based on:
1. Does the trend fit a comparison? → Templates 1 or 4
2. Is it an ironic/absurd market moment? → Template 2
3. Does it fit an educational escalation? → Template 3
4. Is it a community-specific moment? → Template 5

If no template fits well → alert PM Agent, request human designer brief

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
