# Phase 5 — Connectors (the 7 Buckets)

**What this phase does:** Walks the user through the 7 categories of tools every business uses, captures their actual stack in `connections.md`, then enables the two must-have connectors (Gmail and Google Calendar).

**Time:** 15–20 minutes
**Output:** `about-me/connections.md`, Gmail + Calendar enabled in Cowork settings

---

## Step 1 — Greet, explain the 7 buckets

Say:

> "Phase 5 of 9: connectors. Every business has 7 categories of tools, even if you don't think of them this way. We'll walk through all 7 — you tell me what you use for each — then we'll turn on the must-haves. About 20 minutes. Ready? Type **go**."

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

## Step 6 — Recommend 1–2 additional connectors based on business-brain

Now leverage the work the user just did in Phase 3 (business-brain.md). Read it. Then read the just-built `about-me/connections.md` to see which buckets they actually filled vs which are still "none."

For each empty or stub bucket, identify the highest-leverage gap by combining business-brain context with what the user said. Pick the 1–2 most impactful additions.

Then invoke the **/browse-connectors logic** (read `cowork-ai-os/skills/browse-connectors/references/connectors-catalog.md` for the canonical recommendations per bucket). For the recommended bucket(s), pick the connector that matches the user's existing tools (per business-brain).

Show the recommendation in this format:

> "Based on what you just told me about your business, the highest-leverage connector to add next is **[connector name] (bucket: [Bucket])**.
>
> **Why:** [1 sentence tying to business-brain — e.g. 'You said your #1 time sink is replying to discovery-call follow-ups, and a Meetings connector lets `/voice-writer` pull yesterday's transcripts to draft accurate follow-ups in your voice.']
>
> **What you unlock:** [Concrete capability — e.g. '/morning-brief' gains a Tasks section pulling overdue items from your tracker.]
>
> **Want to add it now?** (~5 min, same flow as Gmail/Calendar above) or **save it for next week's tune-up**?"

If they say **add now**: walk them through the same Cowork → Settings → Customize → Add connector flow as Gmail/Calendar. Apply the same safe permission defaults (reads: act, writes: ask, destructive: blocked).

If they say **save for later**: note it in `connections.md` under a new "Connectors I want next" section with the bucket name, the recommended option, the business-brain reason. `/audit` and `/tune-up` will surface this list later.

If business-brain is thin (no clear pain points or tools mentioned), skip Step 6 entirely. Don't force a recommendation. Note in `connections.md`: "Recommendations deferred — build out business-brain.md first."

## Step 7 — Log and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 5 complete: connectors mapped, Gmail + Calendar enabled
- **What we worked on:** Walked the 7 buckets. Enabled Gmail and Calendar with safe permissions. Created quarterly audit calendar reminder.
- **Files touched:** about-me/connections.md, Cowork Settings → Connectors.
- **Decisions I made:** Tools per bucket: <summary>. Optional connectors deferred: <list>.
- **Open loops:** Connectors to add in future tune-ups: <list>.
- **Next time, do:** Phase 6 (folders).
```

Update state.md.

## Step 8 — Hand off

Say:

> "Phase 5 done. I can now read your inbox and calendar safely. Phase 6 sets up the folder structure inside your workspace — where everything I create gets saved. About 5 minutes. Continue?"
