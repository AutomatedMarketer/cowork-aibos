---
name: audit
description: Scores the user AI business operating system on the 4 Cs (Context, Connections, Capabilities, Cadence). Returns a 0-100 score, breakdown by C, and the top 3 leverage gaps. Trigger when the user says check my system, audit my Cowork AI OS, how am I doing, what is my score, or types /audit.
---

# Audit — Score the Cowork AI OS

You score the user's AI business operating system on a 0–100 scale using the 4 C's framework.

## Read these first

1. the 4 Cs rubric in the appendix below (25 points per C)
2. `about-me/audit-log.md` — past entries, so you can compute the delta
3. `about-me/about-me.md`, `business-brain.md`, `writing-rules.md`, `memory.md`, `connections.md`, `skills-tour.md` — to assess the current state
4. `about-me/memory-log.md` — **if it exists**, this is the cold archive of older memory entries that rotated out of `memory.md`. Read it for the full history when assessing Context (C1) — recency of appends, depth of session activity over weeks/months, evidence of pivots. Skip if absent.

## What to score

### Context (0–25)
- Are all 4 about-me/ files filled in (no `~~placeholder` left)?
- Does writing-rules.md have 3+ writing samples?
- Has memory.md been appended to recently (within the last 7 days)?
- Is business-brain.md current (or stale relative to memory entries about pivots/changes)?

### Connections (0–25)
- How many of the 7 buckets in `connections.md` are actually populated (not "none" or empty)?
- How many connectors are enabled in Cowork? (Ask the user if you can't see Settings.)
- Are write actions safely on "Ask before acting"?
- Are there Comms / Tasks / Knowledge connectors, not just Gmail and Calendar?

### Capabilities (0–25)
- Are all 7 Cowork AI OS skills installed and functional?
- Are any role plugins from Anthropic installed (productivity, sales, marketing, etc.)?
- Are there any custom skills in `skills-tour.md` or visible to Claude?
- When was the last custom skill built (per memory.md)?

### Cadence (0–25)
- Is the morning brief scheduled and firing?
- Is the weekly tune-up scheduled and firing?
- Are there any other scheduled tasks?
- Is the user's "computer awake" strategy in place (always-on, or accept-when-wake)?

## How to compute the score

1. For each C, walk the criteria above.
2. Assign a 0–25 score. Use the rubric in the appendix below to calibrate.
3. Sum to get the total (0–100).
4. Compare to the most recent entry in `about-me/audit-log.md` to compute deltas.

## How to identify the top gap

The "top gap" is **not** the lowest C. It's the C where the *highest-leverage single change* lives. Examples:

- If Context is 22/25 (just missing a 3rd writing sample) and Connections is 12/25 (5 buckets unconnected), Connections is the gap — adding ClickUp would unlock daily-brief task awareness, more leverage than a 3rd writing sample.
- If Cadence is 8/25 (no scheduled tasks at all) and everything else is good, Cadence is the gap — getting the morning brief scheduled is huge.

Pick the gap by **leverage**, not by lowest score.

## Output format

```markdown
## Cowork AI OS Audit — YYYY-MM-DD

**Total: X/100** (delta: ±Y from last audit on YYYY-MM-DD)

| C | Score | Notes |
|---|---|---|
| Context | X/25 | one-sentence summary |
| Connections | X/25 | one-sentence summary |
| Capabilities | X/25 | one-sentence summary |
| Cadence | X/25 | one-sentence summary |

**Top leverage gap:** [Specific thing — "Add a Tasks-bucket connector (ClickUp or Notion) — would unlock daily-brief task pulls"]

**Top 3 things to consider this week:**
1. [Most leverage]
2. [Second]
3. [Third]

Want to act on the top gap right now? Type **fix it**. Want to wait for Friday's tune-up? Type **wait**.
```

## After showing the score

Append a new entry to `about-me/audit-log.md` using the format in `templates/audit-log.md`.

If the user says **fix it**:
- Pretend you're at Gate 3 of the tune-up loop.
- Propose ONE specific change. Get approval. Make the change. Confirm.

If the user says **wait** or doesn't reply:
- Note in `about-me/memory.md` that the audit ran and the user deferred action to the next tune-up.
- **Then run the auto-archive check** per the rules in `about-me/memory.md` (Auto-archive section). If `memory.md` now exceeds 30 entries, move the oldest overflow into `about-me/memory-log.md`. Silent.

## Tone

Be specific, never generic. Don't say "your context is decent" — say "your business-brain hasn't been updated since [date], even though memory.md mentions you launched [thing] in March." Cite specifics. Show your work.


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
