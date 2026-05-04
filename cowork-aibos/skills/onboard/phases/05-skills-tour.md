# Phase 5 — Skills Tour

**What this phase does:** First, turns on the four built-in Anthropic skills AIBOS depends on (Skill Creator, docx, pptx, canvas design). Then shows the user every AIBOS skill with a tiny live demo. Plants the seed for `/add-skill` as the bridge to building their own.

**Time:** 20 minutes
**Output:** Built-in skills enabled in Settings, `about-me/skills-tour.md` log of what was demoed

---

## Step 1 — Greet, set context

Say:

> "Phase 5 of 7: skills tour. Two parts. First, we turn on four built-in Cowork skills that AIBOS needs to do its job. Then I'll show you each AIBOS skill with a quick demo. About 20 minutes. Ready? Type **go**."

Wait for `go`.

---

## Step 2 — Enable the four built-in Anthropic skills

These ship with Cowork but are OFF by default. AIBOS needs them ON.

Tell the user:

> "Open Cowork → **Settings** → **Skills**. You'll see a list of built-in skills with toggles. Turn ON these four (and only these four for now):
> 
> - **Skill Creator** — required. /add-skill hands off to this when you build new custom skills. Without it, /add-skill won't work.
> - **docx** — for when you ask me to draft a proper Word document.
> - **pptx** — for when you ask me to build a slide deck.
> - **canvas design** — for visual outputs (posters, infographics, diagrams).
> 
> Leave the others OFF for now (xlsx, pdf, algorithmic art, etc.). You can turn them on later if you need them — they each consume context, and AIBOS doesn't need them to work.
> 
> Tell me when those four are toggled ON."

Wait for confirmation.

If they ask "why these four specifically?" — explain:

- Skill Creator is the carpenter for `/add-skill`. Mandatory.
- docx and pptx are how Cowork produces real .docx and .pptx files instead of just markdown. Most business deliverables need them.
- Canvas design is for any visual work — it's lighter than algorithmic art and covers the common cases.

---

## Step 3 — Verify Skill Creator is actually working

Tell the user:

> "Quick verify on Skill Creator since the rest of AIBOS depends on it. Type this in your current task: **'List the skills I can see right now.'** Skill Creator should appear in the list."

If it does NOT appear:
- Walk them through Settings → Skills again.
- Common issue: the toggle didn't save. Have them refresh / restart Cowork.
- If still failing, note in `_aibos/state.md` as `skill_creator_pending: true` so /add-skill knows to re-check later.

If it does appear: tell them "Good — that's the foundation. Now the AIBOS tour."

---

## Step 4 — Tour each AIBOS skill

Now that Cowork's built-ins are ready, walk the 7 AIBOS skills.

For each of the 7 below, do this pattern:

1. **Name it** in slash + plain English: "/[name] — also works if you say [plain English trigger]"
2. **What it does in one sentence**
3. **Run a tiny live demo** — actually invoke the skill with a simple input
4. **Move on** when the user says "got it" or "next"

### Skill 1: /onboard

Say:

> "**/onboard** — also works if you say **start onboarding** or **continue onboarding**.
> 
> This is the skill we're running right now. It walks you through this 7-phase install. Resumable from any phase. You won't need it again after we finish, except if you ever want to redo a specific phase."

Move on.

### Skill 2: /audit

Say:

> "**/audit** — also works if you say **check my system**.
> 
> Scores your AIBOS on the 4 C's (Context, Connections, Capabilities, Cadence) and tells you the top 3 gaps. We'll run it for real in phase 7. Demo: I'll show you what the output looks like."

Show a sample audit output (use the example from `templates/audit-log.md`). Don't actually run the audit yet — that's phase 7.

Move on.

### Skill 3: /level-up

Say:

> "**/level-up** — also works if you say **what should I improve next**.
> 
> Asks 5 quick questions and tells you the single highest-leverage thing to add to your operating system. Different from /audit — audit measures, level-up recommends. Ready for a quick demo?"

Wait for `go`. Run the skill briefly with the user's actual context. Show the recommendation. Move on.

### Skill 4: /tune-up

Say:

> "**/tune-up** — also works if you say **weekly tune-up**.
> 
> This is the one I'm most excited about. It runs once a week — automatically, on a timer — and walks you through ONE specific improvement to your operating system. Could be: build a new skill, refine an existing one, add a connector, update your business-brain. Six months from now, that's 24 improvements. Your AIBOS will look completely different. We'll set up the schedule in phase 6. No demo needed yet."

Move on.

### Skill 5: /morning-brief

Say:

> "**/morning-brief** — also works if you say **morning brief**.
> 
> Reads your calendar and inbox and writes you a structured brief: today's priority, your meetings, urgent emails, draft replies. Set to fire automatically every morning at the time you picked at install. Quick demo — I'll generate one right now."

Run `/morning-brief` (call the skill). Show the output. Move on.

### Skill 6: /voice-writer

Say:

> "**/voice-writer** — also works if you say **write this in my voice**.
> 
> Drafts anything — emails, posts, replies, captions — using your writing-rules.md. Includes the anti-AI kill list pass. Demo: tell me what you want drafted."

If the user gives an example, run it and show the output. If they say "skip the demo," move on.

### Skill 7: /add-skill

Say:

> "**/add-skill** — also works if you say **build me a new skill**.
> 
> This is the bridge to making AIBOS personal. Anthropic's role plugins (productivity, sales, marketing) cover most generic work. But the parts of YOUR business that nobody else's plugin will cover — your specific client onboarding, your specific lead qualification, your specific weekly report — that's what /add-skill is for. It hands off to Cowork's built-in Skill Creator and walks you through building a skill specific to your workflow. We won't build one today, but plant a flag — this is what /tune-up will use later when it suggests 'build a new skill for X.'"

Move on.

## Step 5 — Log the tour

Write to `about-me/skills-tour.md`:

```markdown
# AIBOS Skills Tour — completed YYYY-MM-DD

## Built-in Cowork skills enabled (Settings → Skills)
- ✅ Skill Creator — mandatory, /add-skill depends on it
- ✅ docx — for Word documents
- ✅ pptx — for slide decks
- ✅ canvas design — for visual outputs

## AIBOS skills bundled (slash + plain English aliases)

| Slash | Plain English | What it does |
|---|---|---|
| /onboard | "start onboarding" | The 7-phase install. Resumable. |
| /audit | "check my system" | 4 C's score + top gaps |
| /level-up | "what should I improve next" | Recommends next leverage move |
| /tune-up | "weekly tune-up" | Friday self-improvement loop |
| /morning-brief | "morning brief" | Daily brief from inbox + calendar |
| /voice-writer | "write this in my voice" | Drafts in your voice with anti-AI pass |
| /add-skill | "build me a new skill" | Hand off to Skill Creator |

You don't have to memorize these. Saying the plain English version works just as well as the slash command.
```

## Step 6 — Log to memory and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 5 complete: built-ins enabled, AIBOS skills toured
- **What we worked on:** Enabled Skill Creator, docx, pptx, canvas design. Demoed all 7 AIBOS skills.
- **Files touched:** about-me/skills-tour.md, Settings → Skills (4 toggles).
- **Open loops:** None.
- **Next time, do:** Phase 6 (cadence — set up scheduled tasks).
```

Update state.md.

## Step 7 — Hand off

Say:

> "Phase 5 done. Cowork now has the right built-ins on, and you've seen what AIBOS can do. Phase 6 sets up the two scheduled tasks — your morning brief, and your weekly tune-up. About 10 minutes. Continue?"
