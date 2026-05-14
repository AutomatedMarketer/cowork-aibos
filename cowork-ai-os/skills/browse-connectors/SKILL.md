---
name: browse-connectors
description: Recommends specific MCP connectors the user should enable in Claude Cowork based on their business and which of the 7 buckets (Revenue, Customer, Calendar, Comms, Tasks, Meetings, Knowledge) are still empty. Reads about-me/connections.md and about-me/business-brain.md, then returns 1–3 connectors to add with reasoning, capability unlocks, and safe permission defaults. Use when the user says "/browse-connectors", "what connectors do I need", "recommend MCPs", "what should I plug into Cowork", "I want to connect my CRM", "I want to connect my tasks", "I want to connect my calendar", "what's missing from my setup", "fill the gaps in my connectors", or any request to discover or wire up new MCP integrations.
---

# /browse-connectors — Recommend the right MCP connectors for this user's stack

You identify which of the **7 Connection buckets** (Revenue, Customer, Calendar, Comms, Tasks, Meetings, Knowledge) are still empty for this user, then recommend **1–3 specific MCP connectors** to fill the highest-leverage gap.

This is a recommender, not a search engine. You pick what fills the user's biggest gap *first*, then optionally next-best. Skills get more powerful when buckets are filled — that's the compound.

## Read these first, every time

1. `about-me/connections.md` — current state, which buckets are populated.
2. `about-me/business-brain.md` — what they sell, what tools they actually use day-to-day (so we recommend connectors that match their existing stack, not random alternatives).
3. `about-me/about-me.md` — their role + tools-used list.
4. `references/connectors-catalog.md` (in this skill's folder) — the bundled catalog of MCP connectors, organized by the 7 buckets.

**v0.10.2 update: live-fetch the directory before falling back to the bundled snapshot.**

Before reading `references/connectors-catalog.md`, follow the procedure in [`lib/fetch-live-catalog.md`](lib/fetch-live-catalog.md). Try the live fetch from `https://claude.com/connectors` first. Fall back to the bundled snapshot ONLY if the live fetch fails. Tell the user which source the recommendations came from.

The bundled snapshot at `references/connectors-catalog.md` remains in place as the offline fallback (and as a useful 7-bucket framework for organizing recommendations) — but it is no longer the primary source.

If `about-me/connections.md` or `business-brain.md` is missing or empty, stop and tell the user: *"I need your `about-me/` files first. Run `/onboard` to build them (or `/audit` to see what's missing)."*

## The 7 Connection buckets (the framework)

| # | Bucket | What it means | Unlocks |
|---|---|---|---|
| 1 | **Revenue** | Payments + accounting (Stripe, QuickBooks) | Revenue dashboards, deal-value-aware skills |
| 2 | **Customer** | CRM (HubSpot, GoHighLevel, Salesforce, Close) | Lead context in drafts, customer-aware skills |
| 3 | **Calendar** | Calendar systems (Google Calendar default; Cal.com, Calendly) | Morning brief, scheduling skills |
| 4 | **Comms** | Team/community chat (Slack, Discord, Telegram, Teams) | Brief team-comms section, thread context for drafts |
| 5 | **Tasks** | Task/project trackers (ClickUp, Notion, Asana, Linear) | "What's at risk today" in brief, task-aware drafts |
| 6 | **Meetings** | Transcripts (Fireflies, Otter, Granola, Fathom) | Yesterday's-meeting recap in brief, follow-up drafts |
| 7 | **Knowledge** | Docs/wikis (Notion, Google Drive, Obsidian, Confluence) | Skills can find existing material instead of regenerating |

`/onboard` Phase 5 enables Calendar (Google Calendar) and one Comms-bucket connector by default. Everything else is opt-in.

## The flow

### Step 1 — Identify which buckets are empty

Read `about-me/connections.md`. For each of the 7 buckets, classify:
- **Filled** — at least one connector is enabled and used
- **Stub** — listed but not actually connected (e.g., "ClickUp" written down but no MCP active)
- **Empty** — nothing for this bucket

Count the empties + stubs. That's the gap surface.

### Step 2 — Rank gaps by leverage for this user

Don't recommend connectors in numerical order. Rank by:

1. **Their stated pain.** If `business-brain.md` says "I'm tired of forgetting tasks across tools," Tasks bucket jumps to #1.
2. **Skill amplification.** Some buckets multiply existing-skill value more than others:
   - Tasks → makes `/morning-brief` significantly stronger (the "what's at risk today" section).
   - Knowledge → makes ALL drafting skills better (less re-generation, more pulling from existing material).
   - Meetings → makes `/voice-writer` follow-ups dramatically more accurate.
3. **Tools they already use.** If business-brain says they live in Notion, prioritize the Notion connector (which fills both Tasks AND Knowledge depending on how they use it). If they say they hate Slack, deprioritize Slack even if Comms is empty.
4. **Permission risk.** Prefer low-risk read-mostly connectors first. Save write-heavy connectors (Stripe, CRM updates) for after the user trusts the system.

### Step 3 — Look up the catalog

Open `references/connectors-catalog.md`. For each bucket you're recommending, read the entries and pick the one(s) that match the user's existing tools (from business-brain).

If the user uses a tool that's in the catalog → recommend it.
If the user uses a tool that's NOT in the catalog → flag it: *"You mentioned [Tool X] but it's not in my catalog. Two options: (a) check Cowork → Settings → Customize → Add connector — search for [Tool X]; (b) if no MCP exists, build a custom skill via `/add-skill`."*
If the user doesn't have a preference → recommend the most common option per bucket.

### Step 4 — Show 1–3 recommendations

Top 3 max. Often 1–2 is enough — don't overwhelm.

Format:

```markdown
### 1. [Connector name] (fills [Bucket])

**Why this fills your biggest gap:** [1 sentence — concrete to their business]
**What you unlock:** [Concrete capability — "Lets `/morning-brief` add a 'what's at risk today' section pulling overdue tasks from your tracker." Be specific about WHICH skill gets better.]
**Add it:**
1. In Cowork: **Settings → Customize → Add connector**
2. Search for **[exact name]**. Click the tile.
3. Sign in via OAuth.
4. **Permission defaults** (set these — don't leave defaults wide open):
   - Reads (search, list, get): **Act without asking**
   - Writes (create, update): **Ask before acting**
   - Destructive (delete, send): **Blocked**
5. Tell me **done** when connected.

**First-week test:** [Concrete prompt the user can try once connected — e.g. "Tomorrow morning, after `/morning-brief`, the brief includes a Tasks section. Verify the items match what's in ClickUp."]

**Gotchas:** [Anything specific — Mac install quirks, auth flow weirdness, rate limits.]

---
```

Then 2 and 3 if relevant. Often just 1 is the right answer — say so.

After the recommendations:

> "Want me to walk you through enabling any of these? Type the number. Want different options for the same bucket? Type **other options for [bucket]**. Want to skip this bucket? Type **skip — next bucket** and I'll move down the priority list."

### Step 5 — If user picks a number

Walk through:
1. Open Cowork → Settings → Customize → Add connector.
2. Search for the connector name. Click Connect.
3. OAuth flow.
4. Set the permission defaults (read above). Walk through this carefully — defaults are usually wider than safe.
5. Wait for "done" from user.
6. Run the first-week test prompt with them, live.
7. Update `about-me/connections.md` — add the connector under its bucket, note the date connected, note the permission level.
8. Append to `about-me/memory.md`:
   ```
   ### YYYY-MM-DD — Connected [Connector name] (bucket: [Bucket]) via /browse-connectors
   - **Permissions set:** [reads: act without asking / writes: ask / destructive: blocked]
   - **First test:** [what they tried]
   - **Outcome:** [worked / iterated / debugged auth]
   ```
   Then run the auto-archive check per the rules in `about-me/memory.md` (Auto-archive section). If `memory.md` exceeds 30 entries, move oldest overflow into `memory-log.md`. Silent.

### Step 6 — If user types "other options for [bucket]"

Show all catalog entries for that bucket, ranked by your same logic. Same format.

### Step 7 — If user says "skip — next bucket"

Move to the next-highest-leverage empty bucket. Repeat Step 4.

---

## Hard safety rules

1. **Never recommend a write-capable connector set to "Act without asking."** Always recommend "Ask before acting" for writes, "Blocked" for destructive. Reads are fine on "Act without asking" because they're not risky.
2. **Never recommend connecting a third-party connector to send email or post to social.** Email send stays BLOCKED via Gmail's own permission. Social posts require approval. These are non-negotiable per `connections.md` and the v0.9 handbook.
3. **Never connect anything from inside this skill.** You walk the user through doing it — they click the buttons. This is Cowork's safety model.

## Edge cases

**User hasn't done `/onboard`.** Tell them to run `/onboard` first. The recommendations are useless without business-brain to inform them.

**All 7 buckets filled.** Celebrate! Then: *"Your bucket coverage is complete. The next leverage move isn't a new connector — it's making sure the connectors you have are running with safe permissions. Want me to invoke `/audit` to review?"*

**User asks for a connector not in the catalog.** Don't invent install instructions. Say: *"[Tool] isn't in my catalog. Best path: in Cowork, Settings → Customize → Add connector — search for it there. The official Anthropic marketplace covers way more than what I've verified."*

**Catalog entry conflicts with user's stated tools.** Defer to the user. If business-brain says they hate Slack, don't recommend Slack even if Comms is empty. Try Discord or Telegram instead.

**User has paid plan vs free tool concerns.** Flag if a connector requires a paid tier of the underlying tool. The catalog notes this when known.

## What this skill does NOT do

- It does not browse the live MCP registry. The catalog is a bundled snapshot.
- It does not configure connectors. The user does that via Cowork's UI.
- It does not handle plugins/skills — that's `/browse-skills`. Connectors ≠ skills.

If the user asks for a skill (not a connector), redirect: *"That sounds like a skill, not a connector — different beast. Type `/browse-skills` for that."*
