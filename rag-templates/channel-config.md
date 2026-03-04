# Channel Configuration
<!--
  INSTRUCTIONS:
  Used by Community Agent to know which channels to monitor and post to.
  Fill in all IDs before deploying — the agent will fail silently if IDs are wrong.
  
  How to find IDs:
  Discord: Enable Developer Mode (Settings → Advanced → Developer Mode), then right-click any channel/server → Copy ID
  Telegram: Use @userinfobot or forward a message from the group to @getidsbot
  
  Delete these comment blocks before deploying.
-->

## Discord

**Server:**
- Guild ID: `[YOUR_DISCORD_GUILD_ID]`
- Server name: `[Your Server Name]` (for reference only)

**Channels — Monitor (sentiment_scan reads these):**
| Channel Name | Channel ID | Purpose |
|-------------|-----------|---------|
| `#general` | `[CHANNEL_ID]` | Main community chat |
| `#trading` | `[CHANNEL_ID]` | Token price discussion |
| `#support` | `[CHANNEL_ID]` | User help requests |
| `#node-operators` | `[CHANNEL_ID]` | Technical community |
| [add more] | `[CHANNEL_ID]` | [purpose] |

**Channels — Post (auto_reply and announcement_push write to these):**
| Channel Name | Channel ID | Use For |
|-------------|-----------|---------|
| `#announcements` | `[CHANNEL_ID]` | Official announcements only |
| `#general` | `[CHANNEL_ID]` | FAQ auto-replies |
| `#support` | `[CHANNEL_ID]` | Support auto-replies |

**Channels — Exclude (never monitor or post):**
| Channel Name | Channel ID | Reason |
|-------------|-----------|--------|
| `#team-internal` | `[CHANNEL_ID]` | Private |
| `#mod-log` | `[CHANNEL_ID]` | Moderation logs |

**Role IDs (for mention formatting):**
- Moderator role: `[ROLE_ID]`
- Core team role: `[ROLE_ID]`

---

## Telegram

**Community Group (two-way — monitor + reply):**
- Chat ID: `[TG_COMMUNITY_CHAT_ID]`
- Group name: `[Your Community Group Name]` (reference only)
- Bot is admin: `[YES/NO]` — must be YES for bot to read all messages

**Announcement Channel (write-only — push announcements):**
- Channel ID: `[TG_CHANNEL_ID]`
- Channel name: `@[your_channel_username]`
- Bot is admin with post permission: `[YES/NO]`

**Additional Groups (monitor only):**
| Group Name | Chat ID | Language | Notes |
|-----------|---------|----------|-------|
| [e.g. Chinese community] | `[CHAT_ID]` | ZH | Monitor only, no auto-reply |
| [e.g. Korean community] | `[CHAT_ID]` | KR | Monitor only |

---

## Sentiment Scan Scope

<!-- Which channels feed into sentiment_scan() scoring -->

**Included in sentiment score:**
- Discord: `#general`, `#trading`, `#support` (adjust to your most active channels)
- Telegram: Community group

**Excluded from sentiment score (noise):**
- Price-only channels (pure speculation, not useful signal)
- Off-topic channels

---

## Announcement Distribution Matrix

<!-- Which platforms get which announcement types -->

| Announcement Type | Discord #announcements | Telegram Channel | Twitter (Social Agent) |
|------------------|----------------------|-----------------|----------------------|
| Product update | ✅ | ✅ | ✅ |
| Partnership | ✅ | ✅ | ✅ |
| Token event (unlock, listing) | ✅ | ✅ | ✅ |
| Community event | ✅ | ✅ | Optional |
| Crisis statement | ✅ | ✅ | Human decides |
| Routine FAQ | ❌ | ❌ | ❌ |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
