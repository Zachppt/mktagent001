# Roadmap

## v1.0.0 — Complete System (Current)

**9 Agents — all implemented:**
- ✅ PM Agent — orchestrator, routing, weekly reports, memory compression
- ✅ Social Agent — Twitter/X, LinkedIn, memes, 4h trend monitoring, Day+7 feedback
- ✅ Content Agent — 5 blog types, video scripts, design briefs, SEO, performance learning
- ✅ Data Agent — token price (5min), competitor scan, social/SEO analytics, insights
- ✅ BD Agent — Apollo.io prospecting, 5 email types, HTML proposals, 7-day follow-ups, event scouting
- ✅ Finance Agent — PDF invoice extraction, daily budget burn, contract expiry, CPM calculator
- ✅ Ecosystem Agent — 4 event announcement types, quarterly brand audit, partner prospecting
- ✅ Community Agent — 15min sentiment scan, <2min FAQ auto-reply, crisis drafting, announcements
- ✅ Security Agent — 6h impersonation scan, 12h phishing check, weekly API audit, daily account audit

**Framework:**
- ✅ Agent template (`agents/_TEMPLATE/`) for adding new agents
- ✅ Two-layer Skill structure (full pack + individual agent installs)
- ✅ 20 RAG templates covering all agents
- ✅ Multi-model cost-optimized config (all 9 agents, all env vars)
- ✅ `ADD_AGENT.md` extensibility guide with PR checklist
- ✅ `deploy.sh`, `update.sh`, `copy-rag.sh` automation scripts

**Estimated total system cost: ~$30–50/month**

---

## v1.1.0 — Hardening & DX

- 🗓 `scripts/validate.sh` — pre-deploy check: verifies all RAG files filled, no placeholders remain
- 🗓 `scripts/health-check.sh` — post-deploy: pings all 9 agents and reports status
- 🗓 GitHub Actions CI — validates SKILL.md frontmatter on every PR
- 🗓 `docs/COST_GUIDE.md` — actual vs estimated cost tracking guide
- 🗓 Notion setup guide — step-by-step for creating all required DB schemas

---

## v1.2.0 — Extended Integrations

- 🗓 Discord bot setup guide (Community Agent enhanced)
- 🗓 Telegram channel + group dual-mode setup guide
- 🗓 Google Analytics integration for Content Agent performance tracking
- 🗓 Dune Analytics integration for Data Agent on-chain metrics
- 🗓 CoinMarketCap fallback for Data Agent token monitoring

---

## v2.0.0 — Cross-Agent Intelligence

- 🗓 Shared signal bus — agents publish findings that other agents subscribe to
- 🗓 PM Agent strategy mode — weekly cross-agent pattern synthesis
- 🗓 A/B test framework for Social and Content agents
- 🗓 Automated RAG refresh — Data Agent updates competitor-intel.md weekly

---

## Contributing

Open an issue to propose a new agent, integration, or improvement.
See [ADD_AGENT.md](ADD_AGENT.md) for the contribution guide.

PRs that add new agents are merged monthly after review.
