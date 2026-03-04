# Content Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Notion API | Content calendar read/write | `NOTION_TOKEN`, `NOTION_CONTENT_DB_ID` | 3 req/sec |
| Google Drive | Asset read/write, RAG doc sync | `GDRIVE_CREDENTIALS` | 100 req/100sec |
| SerpAPI | SEO keyword ranking checks | `SERPAPI_KEY` | 100 searches/month (free tier) |

---

## Usage Notes

### Notion API
```
Used in: blog_writer() (status write-back), content_review() (log)
Database: $NOTION_CONTENT_DB_ID
Fields written: Title, Type, Status, PublishDate, PerformanceTag
Auth: Bearer $NOTION_TOKEN
```

### Google Drive
```
Used in: blog_writer() (final output upload), rag sync
Output folder: $GDRIVE_CONTENT_FOLDER_ID
Auth: Service account via $GDRIVE_CREDENTIALS (JSON key file path)
Notes: Final approved content is uploaded as .md file; filename format: YYYY-MM-DD-slug.md
```

### SerpAPI
```
Used in: content_review() SEO check (optional — falls back to manual keyword count if unavailable)
Endpoint: GET https://serpapi.com/search?q={keyword}&api_key=$SERPAPI_KEY
Notes: Only called for PEAK_INSIGHT and GUIDANCE type posts (highest SEO priority)
       Free tier: 100 searches/month — use sparingly
```

---

## Error Handling

- Notion write failure: retry after 5s, max 3 times; if fails, log locally and alert PM Agent
- Google Drive auth failure: escalate to PM Agent immediately, do not lose draft
- SerpAPI quota exhausted: skip SEO rank check, flag in content_review() report as "SEO check skipped"

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Notion, Google Drive, SerpAPI |
