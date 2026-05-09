# Connectors

Cowork AI OS is **tool-agnostic by category**. It describes workflows by the *kind* of tool, not specific products. The user's `connections.md` (built during /onboard Phase 3) maps their actual tools to these categories.

This convention matches Anthropic's open-source plugins (productivity, sales, marketing, etc.) — any MCP server in a category works.

---

## Required for full functionality

These two are enabled during `/onboard` Phase 3. Cowork AI OS works without them, but the morning brief becomes much weaker.

### Email
- **Default:** Gmail (Google Workspace OAuth)
- **Used by:** `/morning-brief` (urgent inbox triage), `/voice-writer` (when drafting replies)
- **Permissions:** read-only by default. Drafts created on user request need approval. Sends are BLOCKED by default.

### Calendar
- **Default:** Google Calendar
- **Used by:** `/morning-brief` (today's agenda), `/onboard` (creating quarterly audit reminder), any skill that asks "when do I have time for X"
- **Permissions:** read-only by default. Event creation/update needs approval.

---

## Optional — supercharge specific skills

These map to the 7 buckets. None required. Each one unlocks specific capabilities.

### Tasks bucket (project tracker)
- **Examples:** ClickUp, Notion, Asana, Linear, Monday, Jira, Trello, GoHighLevel pipelines
- **Unlocks:** `/morning-brief` adds "what's at risk today" section. `/voice-writer` can pull task context into drafts.

### Comms bucket (chat)
- **Examples:** Slack, Microsoft Teams, Discord
- **Unlocks:** `/morning-brief` can flag DMs needing replies. `/voice-writer` can pull thread context.

### Meetings bucket (transcripts)
- **Examples:** Fireflies, Otter, Granola
- **Unlocks:** `/morning-brief` can include "yesterday's meeting recap." Voice-writer can draft follow-ups using actual quotes.

### Knowledge bucket (docs/wikis)
- **Examples:** Google Drive, Notion, Obsidian (local), Confluence
- **Unlocks:** Skills can find existing material rather than re-generating it. Big context win.

### Customer bucket (CRM)
- **Examples:** GoHighLevel, HubSpot, Close, Salesforce
- **Unlocks:** Custom skills built via `/add-skill` can integrate customer context into drafts and reports.

### Revenue bucket (payments / accounting)
- **Examples:** Stripe, QuickBooks, Xero
- **Unlocks:** Custom revenue dashboards and reports via `/add-skill`.

---

## How to add a new connector

In Cowork:
1. **Settings → Connectors → Add connector**
2. Search for the tool. Click the tile. Click **Connect**.
3. Sign in via OAuth.
4. Set **tool permissions** for safety:
   - Reads (search, list, get): **Act without asking**
   - Writes (create, update): **Ask before acting**
   - Destructive (delete, send): **Blocked** or **Ask before acting**

Then update `about-me/connections.md` to note the new connector.

---

## Permission philosophy

**Read-first, always.** Reads happen all the time and must be fast. Writes happen rarely but need oversight. Destructive actions need explicit human approval, every time.

Specifically:

- `send_email` → **Blocked** by default. Drafts only. The user sends from Gmail.
- `delete_*` → **Ask before acting**. Always.
- `create_*`, `update_*` → **Ask before acting**.
- `read_*`, `search_*`, `list_*`, `get_*` → **Act without asking**.

Auditing these every quarter is in your calendar — `/onboard` Phase 3 created the recurring reminder.
