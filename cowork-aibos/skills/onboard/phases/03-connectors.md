# Phase 3 — Connectors (the 7 Buckets)

**What this phase does:** Walks the user through the 7 categories of tools every business uses, captures their actual stack in `connections.md`, then enables the two must-have connectors (Gmail and Google Calendar).

**Time:** 15–20 minutes
**Output:** `about-me/connections.md`, Gmail + Calendar enabled in Cowork settings

---

## Step 1 — Greet, explain the 7 buckets

Say:

> "Phase 3 of 7: connectors. Every business has 7 categories of tools, even if you don't think of them this way. We'll walk through all 7 — you tell me what you use for each — then we'll turn on the must-haves. About 20 minutes. Ready? Type **go**."

Wait for `go`.

## Step 2 — Walk the 7 buckets

Read `reference/7-buckets.md` for the canonical descriptions. Ask one bucket at a time. Format each question as:

> "**Bucket X — [name]:** [one-sentence description]. What do you use for this? (If nothing, say 'none.')"

For example, for bucket 1:

> "**Bucket 1 — Revenue:** Where money comes in, where you check how the business is doing. Like Stripe, GoHighLevel payments, QuickBooks. What do you use for this?"

Walk all 7:
1. Revenue
2. Customer
3. Calendar
4. Comms
5. Tasks
6. Meetings
7. Knowledge

For each answer, record it. After all 7, build `about-me/connections.md` from `templates/connections.md` and the user's answers. Show, iterate, save.

## Step 3 — Enable Gmail

Say:

> "Two must-haves first: Gmail and Calendar. We're enabling Gmail with **safe permissions** — Claude can read and search your inbox, but every send or delete needs your approval. Here's what to do:
> 
> 1. Open Cowork → Settings → Connectors → Add connector
> 2. Search for Gmail. Click the tile. Click Connect.
> 3. Sign in with your Google account. Read the permission list. Click Allow.
> 4. Tell me when it's connected."

Wait for confirmation.

Then run a permission check. Tell the user:

> "Now I'll set the safe permissions. In Cowork, go to Settings → Connectors → Gmail → Tool permissions. Set:
> - **search_emails, get_email, list_labels:** Act without asking
> - **create_draft:** Ask before acting  
> - **send_email:** Blocked
> - All other writes: Ask before acting
> 
> Tell me when those are set."

Wait for confirmation.

Then test: ask Claude (in the same session) to "list 5 most recent unread emails with sender, subject, date — read-only." Confirm it returns real data.

## Step 4 — Enable Google Calendar

Same flow as Gmail:

1. Settings → Connectors → Add connector → Google Calendar
2. OAuth flow with the same Google account
3. Tool permissions:
   - **list_events, get_event, search_calendar:** Act without asking
   - **create_event, update_event, delete_event:** Ask before acting
4. Test by asking Claude to list every event today and tomorrow.

## Step 5 — The quarterly audit reminder (auto-create)

Tell the user:

> "Permissions can drift. Cowork updates and sometimes new tools get added. I'm going to put a recurring 30-minute reminder on your Google Calendar — first Saturday of January, April, July, October — to audit your connectors. Sound good? Type **yes** to create it."

Wait for `yes`. Then create the recurring event:

- **Title:** Claude Cowork quarterly audit
- **When:** First Saturday of January, April, July, October — 9 AM, 30 min
- **Notes:** "Open Cowork → Settings → Connectors. Review every Always Allow. Remove unused connectors. Check for new connector types Anthropic added."

Show the event details before creating. Click Allow once.

## Step 6 — Optional: other connectors

Read the user's `connections.md`. For any tool they listed in another bucket that has an obvious Cowork connector (Slack, Notion, Google Drive, Fireflies), mention it:

> "You said you use [Slack] for Comms. There's a Cowork connector for it — we can enable now or later. Later means we'll cover it in next week's tune-up. Now or later?"

Don't push. If they say "later," note it in `connections.md` under "Connectors I want next."

## Step 7 — Log and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 3 complete: connectors mapped, Gmail + Calendar enabled
- **What we worked on:** Walked the 7 buckets. Enabled Gmail and Calendar with safe permissions. Created quarterly audit calendar reminder.
- **Files touched:** about-me/connections.md, Cowork Settings → Connectors.
- **Decisions I made:** Tools per bucket: <summary>. Optional connectors deferred: <list>.
- **Open loops:** Connectors to add in future tune-ups: <list>.
- **Next time, do:** Phase 4 (folders).
```

Update state.md.

## Step 8 — Hand off

Say:

> "Phase 3 done. I can now read your inbox and calendar safely. Phase 4 sets up the folder structure inside your workspace — where everything I create gets saved. About 5 minutes. Continue?"
