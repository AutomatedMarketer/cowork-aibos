---
name: tune-up
description: The weekly self-improvement loop. Runs as a scheduled task (default Friday 4 PM) and on demand. Walks 5 gates with approval at every one - pulse, score, propose, execute, log. Makes ONE change per week to the user Cowork AI OS. Trigger when the user says weekly tune-up, tune up, improve my system, or types /tune-up.
---

# Tune-Up — The Weekly Self-Improvement Loop

You walk the user through 5 gates that audit their Cowork AI OS and make ONE specific improvement. This is the engine that keeps Cowork AI OS evolving.

**Critical rule:** ONE change per week. Not three. Not five. ONE. Compound interest, not overwhelm.

**Critical rule:** Approval at every gate. No autonomous changes. The user types **continue**, **go**, **skip**, or **rollback** at every gate.

## Read these first

1. `about-me/audit-log.md` — last entry (for delta calculation)
2. `about-me/memory.md` — the last 7 days of entries
3. `about-me/about-me.md`, `business-brain.md`, `connections.md`
4. the 4 Cs rubric in the appendix below

---

## GATE 1 — PULSE

Read the last 7 days of `memory.md` entries. Summarize in **3 bullets**:

- **Built:** [what got created or shipped]
- **Finished:** [what got closed out / completed]
- **Stalled:** [what's been sitting open]

Show to the user. Say:

> "That's your week. Type **continue** to keep going, or tell me if I missed something."

Wait for `continue`.

---

## GATE 2 — SCORE

Run the same audit logic as `/audit` (see the 4 Cs rubric in the appendix below). Compute a fresh score across the 4 C's.

Compare to the last entry in `audit-log.md`. Compute the delta.

Show:

```
| C | This week | Last week | Delta |
|---|---|---|---|
| Context | X/25 | Y/25 | ±Z |
| Connections | X/25 | Y/25 | ±Z |
| Capabilities | X/25 | Y/25 | ±Z |
| Cadence | X/25 | Y/25 | ±Z |
| **Total** | **X/100** | **Y/100** | **±Z** |
```

Then identify the **one biggest leverage gap**. Be specific:

> "Biggest gap: **[Connections — Tasks bucket]**. Specifically: you said in onboarding that your tasks live in ClickUp, but ClickUp isn't connected. Adding it would let me pull your task list for the morning brief, identify what's at risk, and draft updates."

Say:

> "Type **continue** to see what I propose, or **wait — different gap** if I picked the wrong one."

Wait for `continue`.

---

## GATE 3 — PROPOSE

Pick exactly ONE improvement. Pick the form that fits the gap:

### (a) Update an existing **custom** skill
The user's own skills, built via `/add-skill`. NOT Cowork AI OS's bundled skills — those are read-only and update only when the Cowork AI OS plugin updates. Show before/after diff of the SKILL.md or referenced file.

### (b) Build a new skill
Format a spec for the skill. Hand off to `/add-skill` (which checks Skill Creator is enabled, then drives the construction). The spec should include:
- name, description (the YAML frontmatter)
- when it fires
- what it reads
- what it does
- what it writes

### (c) Add a connector
Name the connector and what it unlocks. Walk through enabling it.

### (d) Refine a context file
Show before/after diff of an `about-me/` file (about-me.md, business-brain.md, writing-rules.md, connections.md). This is also where you go when Cowork AI OS itself needs better context — refine the user's own files, not Cowork AI OS's bundled files.

Say:

> "**My proposal:**
> 
> [The single specific change]
> 
> **Why this:** [leverage reasoning]
> 
> **Cost:** [time + complexity, e.g. '5 minutes, no new accounts needed']
> 
> Type **go** to make this change, or **skip** to defer to next Friday."

Wait for `go` or `skip`.

If **skip**: jump to GATE 5 (log the skip).

---

## GATE 4 — EXECUTE

Make the change. Show the result.

If it was a file change, show the actual file. If it was a connector, walk the user through enabling and confirm it's working. If it was a new skill, hand off to `/add-skill` and let that skill drive.

Say:

> "Change made. **Confirm it looks right** by [specific verification step]. Type **approve** to keep it, or **rollback** to undo."

Wait for `approve` or `rollback`.

If **rollback**: undo the change. Note in memory.md why it was rolled back. Skip to GATE 5.

---

## GATE 5 — LOG

Append to `about-me/audit-log.md`:

```
### YYYY-MM-DD — Triggered by: tune-up
- **Total:** X/100 (delta: ±Y)
- **Context:** X/25
- **Connections:** X/25
- **Capabilities:** X/25
- **Cadence:** X/25
- **Top leverage gap:** [the gap from Gate 2]
- **Action taken this week:** [the change from Gate 3 + 4, or "skipped"]
```

Append to `about-me/memory.md`:

```
### YYYY-MM-DD — Weekly tune-up
- **Score:** X/100 (delta: ±Y)
- **Top gap:** [gap]
- **Action taken:** [change made / skipped / rolled back]
- **Next week likely focus:** [your prediction based on remaining gaps]
```

---

## Closing

Tell the user:

> "Tune-up done. Score: **X/100**. This week we **[summary of action]**.
> 
> Next Friday's tune-up will probably look at **[your prediction]**. Until then, Cowork AI OS keeps running. Have a good week."

That's it. End cleanly.

---

## Edge cases

**User isn't at the computer when this fires (scheduled task scenario):**

If the schedule fires and the user doesn't respond within 30 seconds at Gate 1, save your draft audit to `about-me/audit-log.md` (marked as `pending`), append to memory.md noting "tune-up paused at Gate 1 — user not at desk." Stop. When the user returns and says "continue tune-up," resume from Gate 1.

**It's their first tune-up (no prior audit-log entry):**

Use the baseline from onboarding (Phase 7). If even that doesn't exist, run the audit fresh and treat this as the baseline.

**Score went DOWN:**

Don't be alarmed. Tune-up isn't failing — sometimes context/files drift, or the user paused something. Diagnose: which C dropped? Was it because something stale crept in (e.g. about-me/ files weren't updated when a pivot happened)? The proposal in Gate 3 should address whatever caused the drop.

**User wants to make MORE than one change:**

Politely refuse. Say: "One change per tune-up is the design. Six months of one change a week is 24 improvements compounding. Trying to do five at once usually means none of them stick. Pick the most important — the rest will come around in future tune-ups."

**User asks "can you update Cowork AI OS itself — like the /audit skill or /onboard?":**

No. Cowork AI OS's bundled skills (`/onboard`, `/audit`, `/level-up`, `/tune-up`, `/morning-brief`, `/voice-writer`, `/add-skill`) are read-only — they live in `~/.claude/plugins/` and update only when the Cowork AI OS plugin itself updates from `/plugin update cowork-ai-os`.

If something about Cowork AI OS feels off, the right channel is:

1. Note it in `about-me/memory.md` with `ai-os-feedback:` tag
2. The user reports it at `github.com/automatedmarketer/cowork-ai-os/issues`
3. It gets fixed in the next Cowork AI OS release

What `/tune-up` CAN modify: the user's own about-me/ files, their custom skills (built via `/add-skill`), their connectors, their scheduled tasks. Plenty of room there.


---

## Appendix: The 4 Cs framework (the audit rubric)

Score the user Cowork AI OS on a 0-100 scale. 25 points per C.

### C1 - Context (0-25)
How much does Claude know about the user and their business?
- 0-8: No about-me/ files, or files have ~~placeholders unfilled.
- 9-16: About-me/ has the basics but writing-rules.md has fewer than 3 samples.
- 17-22: All 4 about-me/ files complete. Writing samples real. Memory.md has 5+ entries.
- 23-25: Above plus business-brain.md kept current and memory.md gets appended every session.

### C2 - Connections (0-25)
How many of the 7 buckets (Revenue, Customer, Calendar, Comms, Tasks, Meetings, Knowledge) are reachable?
- 0-8: 0-2 buckets reachable.
- 9-16: 3-4 buckets reachable.
- 17-22: 5-6 buckets reachable.
- 23-25: All 7 reachable with safe permissions (writes need approval).

### C3 - Capabilities (0-25)
How many things can Claude actually do?
- 0-8: Cowork AI OS only, never run a skill beyond /onboard.
- 9-16: Cowork AI OS skills used regularly. No additional plugins.
- 17-22: Cowork AI OS plus 1-2 Anthropic role plugins. 1-2 custom skills built via /add-skill.
- 23-25: Above plus custom skills get refined every few weeks.

### C4 - Cadence (0-25)
How much works on a schedule, vs only when asked?
- 0-8: No scheduled tasks.
- 9-16: Morning brief scheduled. Nothing else.
- 17-22: Morning brief plus weekly tune-up plus at least one custom routine.
- 23-25: Multiple routines firing reliably. Computer-awake reliability solved.
