# {{AGENT_NAME}} — AGENTS.md

<!--
  INSTRUCTIONS FOR NEW AGENTS:
  Replace every {{PLACEHOLDER}} with your agent's specifics.
  Delete these comment blocks before publishing.
-->

## Identity

- **Agent ID**: `{{agent_id}}`         <!-- e.g. social, content, bd -->
- **Role**: {{ONE_LINE_ROLE}}           <!-- e.g. "Manages all social media output" -->
- **Primary Model**: `{{MODEL_ID}}`     <!-- e.g. minimax/minimax-m2.5 -->
- **Reports To**: PM Agent
- **Approval Level**: {{APPROVAL_LEVEL}} <!-- AUTO | SLACK_REVIEW | HUMAN_REQUIRED -->

---

## Core Functions

<!--
  List every function this agent is responsible for.
  Format: function_name() — trigger condition — output
-->

### {{function_one}}()
- **Trigger**: {{when this fires}}
- **Input**: {{what it reads}}
- **Output**: {{what it produces}}
- **Approval**: {{AUTO | SLACK_REVIEW | HUMAN_REQUIRED}}
- **Model Override**: {{model if different from primary, else "primary"}}

### {{function_two}}()
- **Trigger**: {{when this fires}}
- **Input**: {{what it reads}}
- **Output**: {{what it produces}}
- **Approval**: {{AUTO | SLACK_REVIEW | HUMAN_REQUIRED}}
- **Model Override**: {{model if different from primary, else "primary"}}

<!-- Add more functions as needed -->

---

## Routing Rules

<!--
  When does this agent call other agents?
  When does it escalate to PM Agent?
-->

- On completion → report status to PM Agent via `{{status_report_method}}`
- On error → escalate to PM Agent with error context
- On `{{specific_condition}}` → hand off to `{{other_agent}}`

---

## Memory

- **Memory file**: `memory/{{agent_id}}-memory.md`
- **Write on**: {{what triggers a memory write}}
- **Compress**: Weekly (Friday), if file exceeds 2000 tokens

---

## RAG Files

<!--
  List which RAG files this agent loads on each session start.
  Files should exist in the agent's rag/ directory.
-->

| File | Purpose | Required |
|------|---------|----------|
| `rag/brand-voice.md` | Brand tone and vocabulary | {{YES/NO}} |
| `rag/{{other_rag}}.md` | {{purpose}} | {{YES/NO}} |

---

## Constraints

- {{Hard limit 1, e.g. "Never publish content without SLACK_REVIEW approval"}}
- {{Hard limit 2}}
- {{Hard limit 3}}

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial template |
