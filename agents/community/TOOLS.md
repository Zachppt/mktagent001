# Community Agent — TOOLS.md

## Tools Overview

| Tool / API | Purpose | Credential Key | Rate Limit |
|-----------|---------|---------------|-----------|
| Discord Bot API | Read messages, post replies, send announcements | `DISCORD_BOT_TOKEN`, `DISCORD_GUILD_ID` | 50 req/sec |
| Telegram Bot API | Read messages, post replies, send channel updates | `TG_TOKEN_COMMUNITY`, `TG_COMMUNITY_CHAT_ID`, `TG_CHANNEL_ID` | 30 msg/sec |

---

## Usage Notes

### Discord Bot
```
Used in: sentiment_scan() (read), auto_reply() (write), community_update() (write), crisis_draft() (context)
Permissions required:
  - Read Messages / View Channels
  - Send Messages
  - Read Message History
  - Manage Messages (for muting/deleting spam — optional but recommended)
Key channels:
  - Monitor: $DISCORD_MONITOR_CHANNEL_IDS (comma-separated list)
  - Announce: $DISCORD_ANNOUNCE_CHANNEL_ID
Auth: Bot token via $DISCORD_BOT_TOKEN
Notes:
  - Use message intents: GUILD_MESSAGES, MESSAGE_CONTENT
  - Batch sentiment scan: read last 50 messages per 15-min window, not real-time stream
  - Rate limit: space out reads to avoid hitting 50 req/sec cap during bulk scans
```

### Telegram Bot
```
Used in: sentiment_scan() (read group), auto_reply() (write group), community_update() (write channel)
Group chat: $TG_COMMUNITY_CHAT_ID (for reading + FAQ replies)
Channel:    $TG_CHANNEL_ID (for announcements only — write-only)
Auth: Bot token via $TG_TOKEN_COMMUNITY
Methods:
  - Read:  getUpdates (polling) or setWebhook
  - Write: sendMessage
  - Format: parse_mode=MarkdownV2 for announcements
Notes:
  - Polling interval: every 15 min aligned with sentiment_scan() schedule
  - Community group replies use plain text; channel announcements use Markdown
```

---

## Error Handling

- Discord auth failure: alert PM Agent immediately, community is unwatched
- Telegram polling failure: alert PM Agent, attempt reconnect every 5 min
- Reply post failure: log failed reply, retry once, notify PM Agent if retry fails
- Both platforms down simultaneously: HUMAN_REQUIRED escalation to operator

---

## Changelog

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release: Discord bot, Telegram bot |
