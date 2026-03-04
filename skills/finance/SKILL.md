---
name: web3-mkt-agents-finance
description: >
  Finance Agent for Web3 marketing teams. Extracts invoice data from PDFs,
  tracks budget burn against monthly allocations, monitors contract expiry
  dates, calculates multi-channel CPM, and generates monthly budget reports.
  Zero payment actions without HUMAN_REQUIRED approval.
version: 0.1.0
tags: [web3, finance, budget, invoices, contracts, cpm]
metadata:
  openclaw:
    requires:
      env:
        - ANTHROPIC_API_KEY
        - OPENAI_API_KEY
        - NOTION_TOKEN
        - NOTION_FINANCE_DB_ID
        - GDRIVE_CREDENTIALS
        - GDRIVE_INVOICE_FOLDER_ID
        - GSHEETS_CREDENTIALS
        - GSHEETS_FINANCE_SHEET_ID
---

# Finance Agent — Web3 Budget & Operations

Keeps your marketing spend visible and your contracts from quietly auto-renewing.

## Setup

1. Copy `agents/finance/` to `~/.openclaw/workspace-finance/`
2. Fill RAG files in `~/.openclaw/workspace-finance/rag/`:
   - `budget-plan.md` — monthly budget allocation by category
   - `vendor-list.md` — approved vendors with payment details
3. Register in `openclaw.json` under `agents.list` with `id: "finance"`

## What It Does

### Functions
- **invoice_log()** — extracts structured data from PDF invoices, checks for duplicates, logs to Notion
- **budget_tracker()** — daily burn rate check; alerts at 80% (SLACK) and 95% (HUMAN_REQUIRED)
- **contract_monitor()** — daily expiry scan; alerts at 30 days (SLACK) and 7 days (HUMAN_REQUIRED)
- **cpm_calculator()** — calculates and ranks CPM by channel using spend + impression data
- **budget_report()** — monthly spend vs plan report with variance analysis and next-month recommendations

### Approval Model
| Action | Approval |
|--------|---------|
| Invoice extraction | AUTO |
| Budget monitoring | AUTO |
| Contract monitoring | AUTO |
| CPM calculation | AUTO |
| Monthly report | SLACK_REVIEW |
| Any payment | 🔴 HUMAN_REQUIRED |

## Model Configuration

| Task | Model | Why |
|------|-------|-----|
| Invoice extraction | `anthropic/claude-sonnet-4-6` | Precise PDF parsing, zero tolerance for errors |
| Budget/contract monitoring | `openai/gpt-4.1-nano` | Pure arithmetic + threshold comparison |
| Monthly report | `anthropic/claude-sonnet-4-6` | Narrative generation + recommendations |

**Estimated monthly cost: $3–5**

## RAG Files Required

| File | What to put in |
|------|---------------|
| `rag/budget-plan.md` | Category names and monthly allocations (e.g. Social: $2k, KOL: $5k) |
| `rag/vendor-list.md` | Approved vendor names, categories, payment terms |

Templates: `rag-templates/` in the main repo.

## Install
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents/tree/main/skills/finance
```

## Install Full Pack
```
Install this skill: https://github.com/YOUR_USERNAME/web3-mkt-agents
```
