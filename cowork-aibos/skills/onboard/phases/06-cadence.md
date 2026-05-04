# Phase 6 — Cadence (scheduled tasks)

**What this phase does:** Sets up the two foundational scheduled tasks: morning brief (daily) and weekly tune-up (weekly).

**Time:** 10–15 minutes
**Output:** 2 entries in Cowork's `/schedule` panel

---

## Step 1 — Greet, set context

Say:

> "Phase 6 of 7: cadence. We're setting up two automatic routines. The first runs every morning. The second runs once a week and is the engine that keeps AIBOS evolving. About 10–15 minutes. Ready? Type **go**."

Wait for `go`.

## Step 2 — Confirm the times

Read the user's userConfig values from the manifest install:
- `morning_brief_time` (default: 7:00 AM)
- `weekly_tuneup_when` (default: Friday 4:00 PM)

Show them:

> "When you installed AIBOS, you said:
> - Morning brief at: **[time]**
> - Weekly tune-up: **[day and time]**
> 
> Still good, or change?"

If they want to change, update mentally for this session. (We can't change install-time userConfig retroactively — but we can use these new times in the schedule.)

## Step 2.5 — Build brief-preferences.md (the morning brief settings file)

Before scheduling the morning brief, we need to build the preferences file `/morning-brief` reads on every run.

Say:

> "Before we schedule the morning brief, I need to know what *your* useful morning looks like. This is a separate file (`projects/daily-brief/brief-preferences.md`) that the morning brief skill reads every time it fires. Quick questions — about 5 minutes.
>
> Want to **see a sample first** of what a filled-out brief-preferences file looks like? Or **just start the questions**? Type **sample** or **start**."

If `sample`, paste contents of `samples/brief-preferences-sample.md` as a code block. After they read it, ask "Ready? Type **go**."

When they're ready, ask these one at a time:

1. **What time** should the morning brief fire on weekdays? (default: 7:00 AM)
2. **Weekends** — fire or skip?
3. **Senders who ALWAYS matter** — name 3-5 patterns or specific email addresses (e.g. "any current paying client", "replies to my quotes", specific names).
4. **Senders who NEVER matter** — name patterns to ignore (newsletters, receipts, noreply addresses, etc.).
5. **How many emails** to surface per morning? (3-5 recommended)
6. **Calendar events to skip** — anything tagged "personal," all-day events without descriptions, etc.?
7. **Never draft replies to** — what categories of email should NEVER get a draft (pricing, contracts, apologies, emotional content)?
8. **Length target** for the brief — 150-300 words is the default. Shorter or longer?

Use `templates/brief-preferences.md` as the structure. Fill in their answers, replace every `~~placeholder` with their content. Show as a code block. Iterate until approved.

Save to `projects/daily-brief/brief-preferences.md`. Create the `projects/daily-brief/` directory if it doesn't exist.

Tell them: "Saved. The morning brief will read this every time it fires. Now let's schedule it."

## Step 3 — Set up the morning brief

Tell the user:

> "First: the morning brief. Here's what to do.
> 
> 1. In Cowork, click **Schedule** in the left sidebar (sometimes labeled 'Scheduled').
> 2. Click **+ New task**.
> 3. Fill in:
>    - **Name:** Morning brief
>    - **Schedule:** Daily at **[their morning brief time]**
>    - **Model:** Sonnet 4.6
>    - **Folder:** [their workspace path]
>    - **Keep computer awake:** OFF for now
> 4. Paste the prompt I'm about to give you into the **Prompt** field.
> 5. Click **Save task**.
> 
> Tell me when you're at the prompt field."

Wait for confirmation. Then provide this prompt:

```
Run my morning brief skill (/morning-brief). Use my about-me files for context and voice. Save the brief to outputs/daily-brief/YYYY-MM-DD-brief.md. Append a one-line entry to about-me/memory.md noting the brief was generated.
```

Have them paste it and save. Confirm the task appears in the Schedule panel.

## Step 4 — Test fire the morning brief

Tell the user:

> "Click the saved task → click **Run now**. Watch the progress panel. You should see Claude reading about-me files, then the calendar and inbox connectors, then writing the brief file. Open `outputs/daily-brief/` in your file manager and confirm today's brief is there. Tell me what you see."

Wait. If anything is off, troubleshoot. Common issues:
- Connector not authenticated → re-authenticate Gmail/Calendar
- Brief sounds generic → about-me/writing-rules.md may not be loading; check file location

## Step 5 — Set up the weekly tune-up

Tell the user:

> "Second: the weekly tune-up. This is the engine that keeps AIBOS evolving. Same flow as the morning brief.
> 
> 1. Schedule → + New task
> 2. Fill in:
>    - **Name:** Weekly tune-up
>    - **Schedule:** Weekly on **[their tune-up day and time]**
>    - **Model:** Sonnet 4.6
>    - **Folder:** [their workspace path]
>    - **Keep computer awake:** OFF
> 3. Paste this prompt:"

```
Run my weekly tune-up skill (/tune-up). Walk through all 5 gates. Use my about-me files for context. Wait for my approval at every gate. If I'm not at my computer when this fires, save your audit to about-me/audit-log.md and pause at Gate 1 — I'll resume by saying "continue tune-up" when I'm back.
```

Have them save. Confirm it appears.

## Step 6 — Test fire the weekly tune-up

Tell the user:

> "Click Run now on the weekly tune-up. Walk through Gate 1 with me right now — I'll show you what the loop feels like, even though we don't have a full week of data yet."

Run /tune-up. Walk Gate 1 (pulse) and Gate 2 (score) with them. For Gate 3, since this is install day, propose nothing — just demo the format. For Gate 4 and 5, skip — they'll fire next Friday for real.

## Step 7 — Important reality check on scheduled tasks

Tell the user:

> "One thing to know: Cowork scheduled tasks fire **only when Claude Desktop is open and your computer is awake**. They don't run on the cloud (Claude Code does, but Cowork doesn't).
> 
> Two strategies:
> 
> 1. **Leave Claude Desktop running overnight.** Most people do this — the app uses minimal resources. Set Claude Desktop to launch at startup so it's always there.
> 2. **Accept that the brief fires when you wake up.** If your laptop sleeps, the brief generates as soon as you open it in the morning.
> 
> Which works for you? Type **always on** or **fires when I wake up**."

Note their preference in connections.md.

## Step 8 — Log and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 6 complete: scheduled tasks set up
- **What we worked on:** Created morning brief and weekly tune-up scheduled tasks. Test-fired both.
- **Files touched:** Cowork → Schedule panel (2 entries), outputs/daily-brief/ (first brief), about-me/audit-log.md (baseline).
- **Decisions I made:** Morning brief at <time>. Tune-up <day and time>. Computer awake strategy: <choice>.
- **Open loops:** Tune-up will fire for real this <day>. Watch the email arrive.
- **Next time, do:** Phase 7 (verify).
```

Update state.md.

## Step 9 — Hand off

Say:

> "Phase 6 done. AIBOS is now running on a schedule. Last phase: an integrated test that exercises everything you've built, then I generate your baseline 4 C's score. About 15 minutes. Continue?"
