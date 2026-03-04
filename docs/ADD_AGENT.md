# How to Add a New Agent

This is the core extensibility doc. Every future agent follows this exact process.

---

## The 5-Step Process

### Step 1: Copy the Template

```bash
cp -r agents/_TEMPLATE agents/YOUR_AGENT_NAME
```

Replace `YOUR_AGENT_NAME` with a lowercase, hyphen-free ID (e.g. `bd`, `community`, `security`, `finance`).

---

### Step 2: Fill the 4 Workspace Files

In `agents/YOUR_AGENT_NAME/`:

#### AGENTS.md
Define every function your agent is responsible for. For each function, specify:
- Trigger condition
- Input (what it reads)
- Process (step-by-step)
- Output
- Approval tier: `AUTO` | `SLACK_REVIEW` | `HUMAN_REQUIRED`
- Model override (if different from the agent's primary model)

#### SOUL.md
Define personality, tone, and communication patterns. Be specific — vague SOUL.md files produce inconsistent behavior. Include:
- How the agent announces task start/completion
- What it does when it's uncertain
- What it never does

#### HEARTBEAT.md
List all scheduled tasks with cron expressions. Use cheap model overrides for monitoring tasks.

| Cron | Function | Model Override | Description |
|------|----------|---------------|-------------|
| ... | ... | ... | ... |

#### TOOLS.md
Document every external API the agent calls:
- Endpoint
- Auth method and env var name
- Rate limits
- Error handling behavior

---

### Step 3: Create a SKILL.md

In `skills/YOUR_AGENT_NAME/SKILL.md`:

```yaml
---
name: web3-mkt-agents-YOUR_AGENT_NAME
description: >
  One paragraph. What does this agent do? Who needs it? What's unique about it?
version: 0.1.0
tags: [web3, marketing, YOUR_AGENT_NAME]
metadata:
  openclaw:
    requires:
      env:
        - ENV_VAR_1
        - ENV_VAR_2
---
```

Body: Setup steps, function list, model config table, RAG files required, install command.

---

### Step 4: Register in Config

In `config/openclaw.json.template`, add to `agents.list`:

```json
{
  "id": "YOUR_AGENT_NAME",
  "name": "Your Agent Display Name",
  "workspace": "~/.openclaw/workspace-YOUR_AGENT_NAME",
  "model": "CHOSEN_MODEL_ID",
  "description": "One line description."
}
```

Add any new env vars to the `env` block.

---

### Step 5: Add RAG Templates

If your agent needs project-specific RAG files, add templates to `rag-templates/`:
- Use `<!-- INSTRUCTIONS: ... -->` comments to guide users
- Include example content to show the expected format
- Reference them in your agent's `AGENTS.md` RAG Files table

---

## Model Selection Guide

Pick the cheapest model that can do the job:

| Task Type | Recommended Model | Monthly Cost Impact |
|-----------|------------------|-------------------|
| Monitoring / heartbeat | `google/gemini-2.5-flash-lite` | Near zero |
| Structured extraction | `openai/gpt-4.1-nano` | Very low |
| Agentic tasks, speed-critical | `minimax/minimax-m2.5` | Low |
| Structured generation | `openai/gpt-4.1` | Medium |
| Brand voice / long-form | `anthropic/claude-sonnet-4-6` | Medium |
| Deep reasoning | `google/gemini-2.5-flash` | Low-medium |

**Rule**: Only use Claude Sonnet for tasks where brand voice or long-form reasoning is genuinely required. Everything else uses a cheaper model.

---

## Naming Conventions

| Thing | Convention | Example |
|-------|-----------|---------|
| Agent ID | lowercase, no hyphens | `bd`, `community`, `security` |
| Workspace dir | `workspace-{id}` | `workspace-bd` |
| Skill slug | `web3-mkt-agents-{id}` | `web3-mkt-agents-bd` |
| Memory file | `{id}-memory.md` | `bd-memory.md` |
| RAG files | lowercase, hyphenated | `partner-rag.md` |

---

## PR Checklist

Before opening a PR for a new agent:

- [ ] `agents/YOUR_AGENT/AGENTS.md` — all functions defined with approval tiers
- [ ] `agents/YOUR_AGENT/SOUL.md` — tone, communication patterns, escalation behavior
- [ ] `agents/YOUR_AGENT/HEARTBEAT.md` — all scheduled tasks with cron + model overrides
- [ ] `agents/YOUR_AGENT/TOOLS.md` — all external APIs documented
- [ ] `skills/YOUR_AGENT/SKILL.md` — valid YAML frontmatter + setup + model table
- [ ] `config/openclaw.json.template` — agent registered + env vars added
- [ ] `rag-templates/` — any new RAG templates added with instructions
- [ ] `docs/ROADMAP.md` — agent moved from "Planned" to "Available"
- [ ] Cost estimate included in SKILL.md

---

## Current Agent Roster

| Agent | Status | Version |
|-------|--------|---------|
| PM | ✅ Available | 0.1.0 |
| Social | ✅ Available | 0.1.0 |
| Content | ✅ Available | 0.1.0 |
| Data | ✅ Available | 0.1.0 |
| BD | 🗓 Planned | — |
| Finance | 🗓 Planned | — |
| Ecosystem | 🗓 Planned | — |
| Community | 🗓 Planned | — |
| Security | 🗓 Planned | — |
