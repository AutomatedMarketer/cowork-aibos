# Connectors catalog — public overview

This is the public-facing summary of what `/browse-connectors` recommends inside Cowork AI OS. The full machine-readable catalog lives at [`cowork-ai-os/skills/browse-connectors/references/connectors-catalog.md`](../skills/browse-connectors/references/connectors-catalog.md).

Goal: every entry is **verified to work in Claude Cowork** with documented safe permission defaults.

---

## The 7 Connection buckets (the framework)

| # | Bucket | What it means | Unlocks for Cowork AI OS |
|---|---|---|---|
| 1 | **Revenue** | Payments + accounting | Revenue dashboards, deal-value-aware skills |
| 2 | **Customer** | CRM systems | Lead context in drafts, customer-aware skills |
| 3 | **Calendar** | Calendar systems | `/morning-brief`, scheduling skills |
| 4 | **Comms** | Team / community chat | Team comms section in brief, thread context for drafts |
| 5 | **Tasks** | Task / project trackers | "What's at risk today" in brief, task-aware drafts |
| 6 | **Meetings** | Meeting transcripts | Yesterday's-meeting recap in brief, accurate follow-up drafts |
| 7 | **Knowledge** | Docs / wikis | Skills find existing material instead of regenerating |

`/onboard` Phase 5 enables Calendar (Google Calendar) and Gmail by default. Everything else is opt-in.

---

## What's in the initial catalog (v0.10.0)

**Revenue:** Stripe, GoHighLevel (dual-bucket with Customer), QuickBooks, Xero
**Customer:** HubSpot, GoHighLevel, Salesforce, Close
**Calendar:** Google Calendar (default), Cal.com, Calendly
**Comms:** Slack, Discord, Telegram, Microsoft Teams (all four supported by the `brief-source-comms` helper)
**Tasks:** ClickUp, Notion (dual-bucket with Knowledge), Asana, Linear
**Meetings:** Fathom, Fireflies, Otter.ai
**Knowledge:** Notion, Google Drive, Obsidian (local vault — Project 04), Confluence

---

## Permission defaults — non-negotiable

Every entry in the catalog ships with safe permission defaults baked into the recommendation:

- **Reads** (search, list, get): **Act without asking** — reads are constant; ask-every-time is unusable.
- **Writes** (create, update): **Ask before acting** — writes happen rarely and need oversight.
- **Destructive** (delete, send, archive): **Blocked** — never default-on.

`send_email` specifically stays **Blocked** via Gmail's own permission system. Drafts only. The user sends manually. This is non-negotiable per the v0.9 handbook.

---

## Quarterly audit reminder

`/onboard` Phase 5 creates a recurring "Quarterly Connector Audit" calendar event (first Saturday of January, April, July, October). At each audit, review all enabled connectors: revoke ones you don't use, tighten permissions on ones still on overly-permissive defaults, document the audit in `about-me/audit-log.md`.

`/browse-connectors` is also evergreen — run it any time you want to fill another bucket.

---

## Discovery beyond the catalog

The catalog is hand-curated and small (verified > exhaustive). For everything else:

- **Cowork's built-in browser:** Settings → Customize → Add connector. The official Anthropic + community surface.
- **PRs welcome:** if a connector works for you and isn't here, submit a PR at https://github.com/AutomatedMarketer/cowork-ai-os.

---

## What `/browse-connectors` does NOT recommend

- Connectors with destructive permissions enabled by default.
- `send_email` set to anything other than Blocked.
- Workspace-wide / org-wide OAuth scopes when channel- or folder-specific scopes work.
- Anything that requires local MCP servers (Cowork doesn't support those — Code does).
