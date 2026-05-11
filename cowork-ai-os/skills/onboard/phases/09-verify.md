# Phase 9 — Verify (integrated test + baseline audit)

**What this phase does:** Runs an integrated 6-step test that exercises every part of Cowork AI OS at once. Generates the baseline 4 C's audit score. Recommends the next plugin to install. Marks install complete.

**Time:** 15–20 minutes
**Output:** `outputs/ai-os-verification/YYYY-MM-DD-test.md`, `about-me/audit-log.md` (entry 1), updated state.md (`install_complete: true`)

---

## Step 1 — Greet, set context

Say:

> "Phase 9 of 9: verify. We're running one big end-to-end test that exercises every part of what you just built — context, connections, voice, capabilities, cadence. Then I generate your baseline score on the 4 C's. About 15–20 minutes. Last phase. Ready? Type **go**."

Wait for `go`.

## Step 2 — Run the 6-step integrated test

Tell the user:

> "I'll run six steps. After each, I'll show you what happened. If anything fails, I'll tell you which earlier phase to revisit."

### Step 2a — Load context

Read all 4 about-me files. Summarize in 3 sentences using the user's actual words: who they are, what they're working on, their top writing rules.

Show the summary. Ask: **"Does this sound like you? Type yes / no."** If no, the about-me/ files may be empty or in the wrong place. Tell them to redo phase 2.

### Step 2a.5 — Verify built-in skills are enabled

Ask the user:

> "Quick check: open Cowork → Settings → Skills. Are these four toggled ON?
> - Skill Creator
> - docx
> - pptx
> - canvas design
> 
> Type **all on** or tell me which is missing."

If any are missing, walk them through enabling. Do NOT proceed to Step 2b until all four are confirmed ON. Skill Creator especially — if it's off, `/add-skill` won't work and `/tune-up` Gate 3 option (b) breaks.

### Step 2b — Pull live data

Use the Gmail and Calendar connectors:
- List all Calendar events for the next 7 days (title, start, duration, location)
- List the 3 most urgent unread emails from real humans (last 72 hours, exclude newsletters)

Show the results. If either fails, tell them to redo phase 3.

### Step 2c — Identify the highest-leverage calendar item

Pick the ONE most consequential event from the next 7 days. Explain in 2 sentences why.

Show. Ask: **"Sound right?"**

### Step 2d — Voice-writer test

Use the user's `writing-rules.md`. Draft a 3-part LinkedIn series about that calendar item — each post 3–5 sentences in their voice, **none** of the banned AI phrases from the kill list.

Show all 3 posts. Ask: **"Does this sound like you?"** If no, the writing-rules.md needs more samples — note it as an open loop.

### Step 2e — Save the deliverable

Save the LinkedIn series to `outputs/ai-os-verification/YYYY-MM-DD-linkedin-series.md`. Confirm the full path.

### Step 2f — Self-report

Tell the user honestly which of steps 2a–2e succeeded, which had issues, and specifically which phase to revisit for each failure.

## Step 3 — Run the baseline audit

Now invoke `/audit` (the audit skill). Read `reference/4-cs-framework.md` for the rubric.

Score the user 0–100 across:
- **Context (0–25):** based on richness of about-me/ files
- **Connections (0–25):** how many of the 7 buckets are reachable
- **Capabilities (0–25):** Cowork AI OS skills installed (will be 7/7 if install went clean)
- **Cadence (0–25):** scheduled tasks running (should be 2 — morning brief and tune-up)

Append a baseline entry to `about-me/audit-log.md` using the format from `templates/audit-log.md`. Trigger field: "onboard."

Show the score to the user. Identify the **single top gap**.

Say something like:

> "Your baseline score is **[X]/100**. The biggest gap is **[Connections / Capabilities / etc.]** — specifically, **[one specific thing]**. The weekly tune-up will work on this first."

## Step 4 — Recommend the next plugin

Read the user's `about-me/about-me.md` for their role. Pick the single best next plugin to install.

Say:

> "Most people in your role install **[plugin name]** next. It covers **[what it covers]**. Want me to walk you through installing it now (5 minutes), or save that for next session? Type **install now** or **save for next time**."

If `install now`, walk them through:
1. Cowork → Customize → Browse plugins
2. Find the plugin name
3. Click Install
4. Follow the plugin's own install steps

If `save for next time`, note it in memory.md as the recommended next session.

## Step 5 — Mark install complete

Update `_aibos/state.md`:
- `phases.9.status: complete`
- `install_complete: true`
- `installed_at: <today's date and time>`
- `baseline_audit_score: <score>`

## Step 6 — Final memory entry

Append to memory.md:

```
### YYYY-MM-DD — Cowork AI OS install complete

- **What we worked on:** Finished the 9-phase install. Ran the integrated verification test. Generated baseline 4 C's audit.
- **Files touched:** outputs/ai-os-verification/, about-me/audit-log.md (entry 1), _aibos/state.md (install_complete: true).
- **Baseline score:** <X>/100. Biggest gap: <gap>.
- **Decisions I made:** Next plugin to install: <plugin>. Computer awake strategy: <strategy>.
- **Open loops:** <list any phase that had warnings, e.g. "writing-rules.md only has 2 samples — should add a 3rd">
- **Next time, do:** Wait for the morning brief to fire tomorrow at <time>. Friday's tune-up will be the first real one.
```

## Step 7 — Closing message

Say:

> "Your AI business operating system is live.
> 
> Tomorrow morning at **[time]**, you'll get your first morning brief in `outputs/daily-brief/`. **[Day and time]**, the first weekly tune-up fires — that's where Cowork AI OS starts evolving on its own.
> 
> Try this right now if you want: open a fresh Cowork task and type **'morning brief'** to manually trigger today's. Or just close everything and go live your day. Cowork AI OS will be here when you come back.
> 
> One last thing: I left an open loop in your memory file — **[loop, e.g. 'writing-rules.md only has 2 samples']**. Friday's tune-up will probably surface that. Type **continue** if there's anything else, or just close this session. You're done."

That's it. The orchestrator's job is done.
