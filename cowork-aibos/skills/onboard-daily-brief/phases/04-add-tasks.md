# Phase 4 — Add Tasks (today.md)

**Goal:** Scaffold `projects/daily-brief/today.md`. Have user fill in real tasks. Run the brief and confirm the Tasks section renders correctly per Q5 rules.

**Time:** ~15 minutes. Pillar: Sources.

**Why this phase exists:** A morning brief without your tasks is half a brief. The brief reads `today.md`. You own the file. Claude doesn't write to it. Ever.

---

## Script — what to say

> *"Phase 4 wires in your tasks. We're not integrating ClickUp, Asana, or any other system. You maintain a markdown file. The brief reads it. That's it.*
>
> *Why a markdown file? Because the brain that knows what's actually important today is yours. Any system that tries to score-rank your tasks is going to get it wrong sometimes. A markdown file you wrote 5 minutes ago is the most accurate task list in the world."*

---

## Step 1 — Scaffold today.md

Copy from this skill's `templates/today.template.md` to the user's workspace at `projects/daily-brief/today.md`.

Open the file. Show the user:

```markdown
# Today — <day, date>

- [ ] <task>
- [ ] <task>
- [ ] <task>

---

# Parking Lot — This Week

- [ ] <task>

---

# Done
```

Tell user:

> *"This is your file. The brief reads only the Today section. Parking Lot doesn't surface. Done is for your reference. Tags supported inline: [QUICK WIN], [OVERDUE], [DELEGATE], [BLOCKED]."*

---

## Step 2 — Have user fill it in

Have user replace the placeholder tasks with 3–5 real tasks for today. If user can't think of 3 today, that's fine — they fill in whatever's actually on their plate.

If user is stuck:

> *"What did you say to yourself this morning when you sat down to work? What were the actual things on your mind to get done? Those are your tasks. Doesn't have to be polished."*

Strong example:

```markdown
# Today — Tuesday May 5

- [ ] Review PR #47 [QUICK WIN]
- [ ] Send Acme Q3 retainer proposal [OVERDUE]
- [ ] Record 3 Loom videos for new client onboarding
```

Weak example (don't accept):

```markdown
- [ ] Work on stuff
- [ ] Catch up on things
- [ ] Be productive
```

These don't pass — there's nothing for the brief to surface that's useful. Push for specifics.

---

## Step 3 — Confirm Q5 rules are sharp

Open `projects/daily-brief/brief-preferences.md`. Scroll to Q5. Confirm:

- File path: `projects/daily-brief/today.md`
- Surface rule: "Today" section, unchecked items only, in user-defined order
- Tag rendering: `[QUICK WIN]`, `[OVERDUE]`, `[DELEGATE]`, `[BLOCKED]`
- Update timing: Sunday-night planning OR daily-morning planning

If Q5 is vague, tighten now using the *Stuck?* prompt from Phase 1.

---

## Step 4 — Run the brief

Have the user run `/morning-brief`.

The brief should now include a Tasks section after Team comms (or after Urgent Inbox if Team comms section is empty/disabled):

```
## Team comms
- ...

## Tasks (today.md)
- [ ] Review PR #47 [QUICK WIN]
- [ ] Send Acme Q3 retainer proposal [OVERDUE]
- [ ] Record 3 Loom videos for new client onboarding

## Quick wins
- ...
```

---

## Step 5 — Diagnose the Tasks section

Ask:

1. *"Are all your unchecked Today items showing?"*
2. *"Is the order matching the order in your file?"*
3. *"Are [QUICK WIN] and [OVERDUE] tags rendering?"*
4. *"Is the Parking Lot section staying out of the brief?"*
5. *"Are checked-off items staying out?"*

**If Parking Lot is leaking in:** Q5 needs to specify "only items under the Today header." Update Q5.

**If completed tasks are showing:** Q5 needs "only unchecked items." Update.

**If tags aren't rendering:** Confirm the tags in `today.md` are spelled exactly as Q5 specifies. `[QUICK WIN]` not `[Quick Win]` or `[QUICKWIN]`.

---

## Step 6 — Establish the update ritual

Tell the user:

> *"This file is yours. You update it. Two patterns work:*
>
> *Pattern A — Sunday night planning. Sit down Sunday night for 10 minutes. Fill in Today and Parking Lot for the whole week. Each morning you tweak.*
>
> *Pattern B — Daily 5-minute morning planning. Sit down before your brief fires. Fill in Today fresh. Pull from Parking Lot if needed.*
>
> *Pick one. Schedule it as a recurring calendar block. The brief is only as good as your today.md is current."*

If user has a strong opinion, capture it in Q5 ("I update Sunday nights" or "I update each morning at 6:30 AM").

---

## Verification

Before marking Phase 4 complete:

- [ ] `projects/daily-brief/today.md` exists with 3+ real tasks
- [ ] Q5 rules in `brief-preferences.md` are specific
- [ ] Brief includes a Tasks section
- [ ] Tasks section shows only Today items, only unchecked, in order
- [ ] Tags render correctly inline
- [ ] User has committed to an update ritual (Sunday night or daily morning)

---

## State update

Append to `_aibos/state-daily-brief.md`:

```
- <ISO timestamp> — Phase 4 (Add Tasks) complete. today.md scaffolded with <N> tasks. Update ritual: <Sunday|daily>.
```

Set `today.md created: true`. Update `current_phase: 5`.

---

## Pause point

> *"Phase 4 complete. You're 67% through. Two phases left. Phase 5 sharpens your draft rules — about 15 minutes. Type `continue onboarding` when ready, or `pause onboarding` to resume later."*

If user continues → load `phases/05-tighten-drafts.md`.
