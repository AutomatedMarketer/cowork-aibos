---
name: level-up
description: Finds the single highest-leverage thing to add to the user AI business operating system next. Asks 5 quick questions, then recommends ONE specific move. Different from /audit - audit measures, level-up recommends. Trigger when the user says what should I improve next, level up my AIBOS, what is next, or types /level-up.
---

# Level-Up — Find the Next Leverage Move

You ask the user 5 quick questions and then recommend the **single highest-leverage thing** to build next. Different from /audit:

- `/audit` measures the current state
- `/level-up` recommends the next action

You can run /level-up after /audit (most useful) or standalone.

## Read these first

1. `about-me/about-me.md`, `business-brain.md`, `memory.md`, `connections.md`
2. The most recent entry in `about-me/audit-log.md` if it exists

## The 5 questions

Ask these one at a time. Don't ask the next until they answer.

### Q1 — Drudgery
> "Walk me through your last week. What did you do **3+ times** that felt manual, boring, or copy-paste?"

### Q2 — Smart-intern test
> "Anything where you thought *'a smart intern could absolutely handle this'* — but you ended up doing it yourself because explaining would take longer?"

### Q3 — Constraint
> "If 100 new clients showed up Monday, what would break first?"

### Q4 — Growth lever
> "What would give you 100 more clients tomorrow if it ran on autopilot?"

### Q5 — Friction
> "What's the one thing in your day that makes you sigh?"

If they say "I don't know" to any question, give them a default based on what's in their about-me/ files and ask if it fits.

## How to recommend

Look at all 5 answers. Pick the ONE that has the most leverage. Leverage = (impact if solved) × (frequency it happens). Recommend a SINGLE next move, in one of these forms:

### Form A — Build a new skill
> "Build a skill called `~~name`. It would: [specific input → specific output]. The skill would automate [the pain]. I'd hand off to /add-skill to actually build it. Want to do that now?"

### Form B — Add a connector
> "Connect [tool name] to Cowork. It would let me [specific capability]. Right now you're doing [X] manually because I can't see [tool]. Want me to walk you through enabling it?"

### Form C — Refine a context file
> "Update `business-brain.md` to capture [specific gap, e.g. 'your new pricing structure for the Build-a-thon offer']. The drafts I generate will hit closer to your voice. Want to do it now?"

### Form D — Schedule a routine
> "Add a scheduled task: `[name]`. It would fire [frequency] and do [specific thing]. Want to set it up?"

### Form E — Install a complementary plugin
> "Install Anthropic's `[plugin]` plugin. It would handle [the work]. Specifically helpful for your situation because [reference the user's context]. Want to walk through installing it?"

## Pick by leverage, not by ease

Don't recommend the easiest thing. Recommend the most leveraged thing. The user can say "too big right now" and you'll downshift — but lead with the high-leverage move.

## After the recommendation

Wait for the user. If they say:

- **yes / go / let's do it** — execute the recommendation. If it's "build a new skill," hand off to `/add-skill`. If it's "add a connector," walk them through. Etc.
- **too big** or **smaller** — recommend the next-highest-leverage move from their answers.
- **save for later** — append to memory.md as an open loop, exit cleanly.
- **already doing this** — apologize for missing the context, ask Q1 again with more specificity.

## After the recommendation is acted on

Append to memory.md:

```
### YYYY-MM-DD — Level-up: [recommendation]
- **Trigger:** /level-up
- **Top answer (drove the rec):** "[user's quote]"
- **Recommendation:** [what was recommended]
- **Action taken:** [executed / deferred / refused]
```


---

## Appendix: The 4 Cs framework (the audit rubric)

Score the user AIBOS on a 0-100 scale. 25 points per C.

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
- 0-8: AIBOS only, never run a skill beyond /onboard.
- 9-16: AIBOS skills used regularly. No additional plugins.
- 17-22: AIBOS plus 1-2 Anthropic role plugins. 1-2 custom skills built via /add-skill.
- 23-25: Above plus custom skills get refined every few weeks.

### C4 - Cadence (0-25)
How much works on a schedule, vs only when asked?
- 0-8: No scheduled tasks.
- 9-16: Morning brief scheduled. Nothing else.
- 17-22: Morning brief plus weekly tune-up plus at least one custom routine.
- 23-25: Multiple routines firing reliably. Computer-awake reliability solved.
