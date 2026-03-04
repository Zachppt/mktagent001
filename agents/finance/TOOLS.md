# Finance Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Google Drive | Invoice PDF ingestion | `GDRIVE_CREDENTIALS`, `GDRIVE_INVOICE_FOLDER_ID` | 100 req/100sec |
| Notion API | Finance DB read/write | `NOTION_TOKEN`, `NOTION_FINANCE_DB_ID` | 3 req/sec |
| Google Sheets | Budget reporting output | `GSHEETS_CREDENTIALS`, `GSHEETS_FINANCE_SHEET_ID` | 300 req/min |

---

## Usage Notes

### Google Drive — Invoice Ingestion
```
Used in: invoice_log() (PDF read)
Watch folder: $GDRIVE_INVOICE_FOLDER_ID
Auth: Service account via $GDRIVE_CREDENTIALS (JSON key path)
Process: Poll folder every hour for new PDFs; download, extract, archive to processed/ subfolder
Notes:
  - Never delete original PDFs — move to processed/ after logging
  - Filename format preserved in Notion record for audit trail
```

### Notion Finance DB
```
Used in: invoice_log() (write), budget_tracker() (read), contract_monitor() (read), budget_report() (read)
Database: $NOTION_FINANCE_DB_ID
Fields:
  Invoices:   VendorName, InvoiceNumber, Amount, Currency, IssueDate, DueDate, Status, SourceFile
  Contracts:  VendorName, ContractValue, StartDate, ExpiryDate, AutoRenew, Status
  Budget:     Category, MonthlyBudget, SpentToDate, LastUpdated
Notes:
  - Append-only for invoices and contracts — never modify existing records
  - Budget records updated on each budget_tracker() run
```

### Google Sheets — Finance Dashboard
```
Used in: budget_report() (write), cpm_calculator() (write)
Auth: Service account via $GSHEETS_CREDENTIALS
Sheet: $GSHEETS_FINANCE_SHEET_ID
Tabs:
  "Budget_YYYY-MM"   → monthly budget vs actual
  "CPM_YYYY-MM"      → CPM comparison by channel
  "Invoices_YYYY"    → annual invoice log
Notes: Human-readable dashboard; Finance Agent writes, humans read
```

---

## Error Handling

- Google Drive auth failure: alert PM Agent immediately, pause invoice processing
- Notion write failure: cache locally, retry 3×, then escalate to PM Agent
- PDF extraction failure (corrupt/unreadable file): log filename + error, notify PM Agent for manual review
- Duplicate invoice detected: halt, write both record references to memory, notify PM Agent

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Google Drive, Notion Finance DB, Google Sheets |
