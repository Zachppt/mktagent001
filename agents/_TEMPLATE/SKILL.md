---
name: web3-mkt-agents-[agent-id]
description: >
  [One sentence describing what this agent does and when to use it.
  This text appears in OpenClaw's skill discovery — make it clear and specific.]
version: 0.1.0
tags: [web3, marketing, [agent-specific-tags]]
metadata:
  openclaw:
    requires:
      env:
        - [REQUIRED_ENV_VAR_1]
        - [REQUIRED_ENV_VAR_2]
      optional_env:
        - [OPTIONAL_ENV_VAR]
---

# [Agent Name] Agent

[One paragraph: what this agent does, who it's for, what problem it solves.]

---

## What It Does

| Function | Description |
|----------|-------------|
| `[function_name()]` | [what it does] |
| `[function_name()]` | [what it does] |

## Approval Tiers

- 🟢 **AUTO** — [list functions that run silently]
- 🟡 **SLACK_REVIEW** — [list functions that need human review]
- 🔴 **HUMAN_REQUIRED** — [list functions that need explicit approval]

## Required Setup

### 1. Fill RAG Template
```bash
nano rag-templates/[filename.md]
# Fill all [PLACEHOLDER] values with your project's data
```

### 2. API Keys Needed
| Key | Where to Get |
|-----|-------------|
| `[ENV_VAR]` | [URL] |

### 3. Copy to Workspace
```bash
bash scripts/copy-rag.sh
```

## Install (standalone)

```
Install this skill: https://github.com/NanRen01/mktagent3/tree/main/skills/[agent-id]
```

## Example Usage

```
# Via PM Agent (recommended):
"[Example task you'd give the PM agent that routes to this agent]"

# Direct:
"[Example direct task for this agent]"
```
