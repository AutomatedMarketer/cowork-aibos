# Phase 6 — Schedule + Calibrate

**Goal:** Schedule `/morning-brief` to fire automatically every weekday at the user's chosen time. Run a 7-day calibration loop. Mark install complete.

**Time:** ~25 minutes for setup. Then 7 days of 2-minute morning check-ins.

**Why this phase exists:** A brief that doesn't run on schedule isn't a brief. A brief that's never tuned is fragile.

---

## Script — what to say

> *"Phase 6 is two things. First, we schedule the brief to fire every weekday at your time from your prefs. Second, we run a 7-day calibration loop. Each morning for the next 7 weekdays, you read the brief and mark each item HIT or MISS or EXTRA in your P02 calibration log. After 7 days, we run /tune-up daily-brief to read your scoring and propose specific edits.*
>
> *Don't skip the calibration. Briefs that aren't tuned drift."*

---

## Step 1 — Set up the Cowork scheduled task

Walk user through:

1. Open Cowork → Scheduled Tasks (gear icon → Schedule)
2. Click **New Task**
3. Configure:
   - **Name:** `Daily Brief`
   - **Skill:** `/morning-brief`
   - **Schedule:** [user's "When the brief fires" time from prefs]
   - **Days:** [user's days from prefs]
   - **Timezone:** [user's local timezone]
   - **Notify:** On (so it pops in Cowork window)
4. Save

Have user verify the task shows up in the Scheduled Tasks list with the next-fire time displayed.

If next-fire time is wrong (showing 7 AM PT when in CT), check the timezone setting. Cowork honors the explicit timezone, not your computer's local time — set it explicitly.

---

## Step 2 — Seed the calibration table

Open `projects/daily-brief/memory.md` (the P02 calibration log — separate from the existing `about-me/memory.md` activity log). Add a new calibration section at the top:

```markdown
# Daily Brief — P02 Calibration Log

## 7-day calibration loop

| Day | Date | HIT / MISS / EXTRA | Notes |
|---|---|---|---|
| 1 | <date> | | |
| 2 | <date> | | |
| 3 | <date> | | |
| 4 | <date> | | |
| 5 | <date> | | |
| 6 | <date> | | |
| 7 | <date> | | |

---

## Run log
<!-- Team comms pulls and other automated entries appended below -->
```

Define the scoring with the user:

- **HIT:** Brief surfaced exactly what mattered. Nothing important missed. No noise.
- **MISS:** Brief missed something I had to dig out of email or messaging platforms manually after reading the brief.
- **EXTRA:** Brief surfaced noise — items I scanned past or ignored.

Tell user:

> *"Each morning at the end of your brief reading, jot a 1-line note in this table. Example: 'Day 1 - MISS - missed Stripe payment notification because B1 spelling was wrong'. Takes 60 seconds. After 7 days we look at patterns."*

---

## Step 3 — Run the brief one final time manually

Run `/morning-brief` one more time as the integrated test.

Walk through every section together:

- **Priority line** ✓ (one sentence, references a highlight, matches Q7 tone)
- **Today's calendar** ✓ (events present, skip rules respected)
- **Urgent inbox** ✓ (clean, B1 senders, no never-matter noise)
- **Team comms** ✓ (Slack/Discord/Telegram/Teams items, channels filtered, ≤8 items total)
- **Tasks (today.md)** ✓ (Today section unchecked items in order)
- **Quick wins** ✓ (specific or section omitted)
- **Drafts ready for review** ✓ (in Gmail Drafts only, Q8 selection applied)

If all sections pass, the brief is shippable.

If any section fails, jump back to the relevant phase to debug.

---

## Step 4 — The 7-day calibration loop (asynchronous)

Tell user:

> *"For the next 7 weekdays, here's your morning ritual:*
>
> *1. Brief fires at [time]*
> *2. Read it (2 minutes)*
> *3. Open `projects/daily-brief/memory.md`, fill in today's HIT/MISS/EXTRA score with a 1-line note (60 seconds)*
> *4. Open Gmail Drafts, edit and send what's worth sending*
> *5. Go about your day*
>
> *On day 8, run `/tune-up daily-brief`. The tune-up skill reads your 7-day calibration log, identifies patterns, and proposes specific edits to brief-preferences.md. You approve or reject each one."*

This step is asynchronous — happens over 7 days, not in this session. Phase script ends here. Day 8 the user runs `/tune-up daily-brief`.

---

## Step 5 — Mark install complete

After Step 4 setup is done (scheduled task live, calibration table seeded, integrated test passed), mark complete.

Append to `_aibos/state-daily-brief.md`:

```
- <ISO timestamp> — Phase 6 (Schedule + Calibrate) complete. Scheduled task live: <time> <days>. 7-day calibration started.
- <ISO timestamp> — daily_brief_complete: true
```

Set:
```
daily_brief_complete: true
completed_at: <ISO timestamp>
scheduled task: true
```

---

## Verification

Before marking Phase 6 complete:

- [ ] Scheduled task is live in Cowork with correct time, days, timezone
- [ ] Next-fire timestamp showing in Scheduled Tasks list
- [ ] `projects/daily-brief/memory.md` has the calibration table seeded
- [ ] User understands the HIT/MISS/EXTRA ritual
- [ ] Final integrated test brief passed all 7 section checks
- [ ] `daily_brief_complete: true` in state file

---

## Final message

> *"Daily Brief expansion complete. Tomorrow morning at [time] the brief fires automatically. Read it, score it in `projects/daily-brief/memory.md`, and on day 8 run `/tune-up daily-brief` to let me propose tune-ups based on what I see in the log.*
>
> *You're done with Project 02. The brief stops being a feature and starts being a habit somewhere between day 12 and day 18 — that's when most people stop checking email at 6 AM. Trust the process.*
>
> *If a brief fires that's noisy, broken, or off — re-run `/onboard-daily-brief`, it'll resume at this phase and we'll diagnose."*

---

## Pause point

This is the last phase. No "continue onboarding" — install is complete. The user's next interaction with this project is either tomorrow's brief firing automatically, or `/tune-up daily-brief` on day 8.
