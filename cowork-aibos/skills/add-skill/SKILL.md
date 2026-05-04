---
name: add-skill
description: Builds a new custom skill specific to the user business by handing off to Cowork built-in Skill Creator with a structured spec. Trigger when the user says build me a new skill, add a skill, I want to automate something, create a skill for a task, or types /add-skill.
---

# Add-Skill — The Bridge to Personal Skills

You help the user build a new skill that's specific to *their* business. AIBOS ships universal skills. This is how the user makes AIBOS personal.

You don't build the skill yourself. You write a structured spec, then **hand off to Cowork's built-in Skill Creator**, which is purpose-built for skill construction. AIBOS is the orchestrator. Skill Creator is the carpenter.

## Pre-flight check (do this first, every time)

Before anything else, verify Skill Creator is enabled. If it's not, /add-skill cannot work — Skill Creator is what actually writes the skill file.

Step 1: ask the user:

> "Quick check before we start: open Cowork → **Settings → Skills**. Is **Skill Creator** toggled ON?"

Wait for `yes` or `no`.

If **yes** → proceed to Step 1 of the workflow below.

If **no** → walk them through enabling it:

> "We need to turn it on first.
> 
> 1. Open Cowork → Settings → Skills.
> 2. Find **Skill Creator** in the list.
> 3. Click the toggle to ON.
> 4. Tell me when it's on.
> 
> If you don't see Skill Creator in the list, your Cowork might be out of date. Check claude.com/download for the latest version."

Wait for confirmation. Then continue.

## Read these first

1. `about-me/about-me.md`, `business-brain.md`, `connections.md` — to ground the skill in their actual business
2. `about-me/writing-rules.md` — if the skill produces any text, voice rules apply
3. the 4 Cs in the appendix below - the new skill should improve at least one C

## Workflow

### Step 1 — Clarify the skill (4 questions max)

Ask these one at a time. Don't ask more than 4. Default what you can.

1. **"What's the trigger? When should I run this skill?"** (e.g. "every Monday morning," "when I say 'lead recap,'" "after a client books a call")
2. **"What does it read or look at?"** (files, connectors, the user's input — be specific)
3. **"What does it produce?"** (a draft, a summary, a file in a specific folder, an action like a Gmail draft)
4. **"What's the success test?"** (how will the user know if the skill is working well — e.g. "the recap saves me 20 min on Monday morning")

If the answers are crystal clear after 2 questions, stop asking and move on.

### Step 2 — Draft the spec

Format a skill spec the user can review:

```markdown
## Proposed skill: ~~name

**Trigger:** [what fires it — slash command + plain English alias]

**Reads:**
- [file 1]
- [connector 1]
- [user input]

**Does:**
1. [step 1]
2. [step 2]
3. [step 3]

**Writes:**
- [output file or action]

**Voice/style rules:** [if it produces text — e.g. "follow writing-rules.md, run anti-AI kill list scan"]

**Why this matters:** [one-sentence leverage explanation]
```

Show the spec. Say:

> "That's the skill. Ready for me to hand it off to Cowork's Skill Creator to actually build the file? Type **build it** or tell me what to change in the spec."

Wait. Iterate the spec until they say `build it`.

### Step 3 — Hand off to Skill Creator

(Skill Creator is already enabled — the pre-flight check at the top of this skill confirmed that.)

Tell the user:

> "Handing this spec off to Skill Creator now. Here's what to do:
> 
> 1. **Open a new Cowork task.**
> 2. **Paste the spec I'm about to give you** plus this instruction:
> 
> *'Use Skill Creator to build a custom skill from this spec. Save it as a project skill in my workspace so it loads in every Cowork session.'*"

Then provide the spec (the markdown block from Step 2) ready to paste.

### Step 4 — Confirm and test

After they've run the Skill Creator handoff, ask:

> "Did Skill Creator finish? Type **yes — what next** when it does."

When they confirm:

1. Help them test the new skill by triggering it.
2. If it doesn't work right, walk them through editing it.
3. Once it works, append to memory.md:

```
### YYYY-MM-DD — Built new skill: ~~name
- **Trigger:** [trigger]
- **Spec source:** /add-skill conversation on [date]
- **Test result:** [pass / pass with edits / failed]
- **What it unlocks:** [one-sentence leverage win]
```

### Step 5 — Update audit-log

The new skill bumps Capabilities. Append a note to `about-me/audit-log.md`:

```
### YYYY-MM-DD — Custom skill added: ~~name
- **C affected:** Capabilities
- **Before:** [score]
- **After:** [score]
```

This makes the next /audit and /tune-up reflect the gain.

## Edge cases

### "I want a skill that does 5 different things"
Politely refuse. Skills should do one thing well. Tell the user: "Let's build the most leveraged of those 5 first. The other 4 can become their own skills later, and they'll be easier to write because each is focused."

### "I want a skill that exists in a plugin already"
Check the recommended plugins appendix below. If Anthropic's productivity / sales / marketing / etc. plugin already has it, recommend installing that plugin instead. Custom skills are for things no existing plugin covers.

### "I want a skill that needs a tool I haven't connected"
Tell the user: "First we need to connect [tool]. Want to walk through that now, or pick a different skill to build first?"

### "I changed my mind, I don't want to build it"
No problem. Append to memory.md:

```
### YYYY-MM-DD — Considered new skill: ~~name (not built)
- **Reason:** [user's words]
- **Spec saved at:** [path, if you saved it]
```

## Tone

This is the moment AIBOS becomes personal to the user's business. Treat it like the unlock it is. Don't over-celebrate, but don't make it feel routine either. Each new skill is the OS getting smarter about *their* world specifically.


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


---

## Appendix: Recommended next plugins (after AIBOS)

For most users:
- **productivity** - manage tasks, calendar, daily workflows. Most universal pick.

By role:
- Coach, agency owner, creator: **marketing** plugin
- Founder, solopreneur: **productivity** plugin
- Sales-led business: **sales** plugin
- Client services: **customer-support** plugin
- Product or SaaS: **product-management** plugin
- Designer: **design** plugin
- Legal, finance, data: **legal**, **finance**, **data** plugins
- Multi-tool searcher: **enterprise-search** plugin

Install via Cowork: Customize -> Browse plugins -> find the plugin -> Install.

When to build custom via /add-skill instead: when the user workflow is specific to their business (their client onboarding, their lead qualification, their weekly internal report) and no plugin covers it.
