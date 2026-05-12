---
name: optimize
description: Speed up a slow Cowork. Diagnoses the workspace handbook + memory file, fixes a known per-turn slowdown bug (pre-v0.9 handbook directive), and archives overflowed memory entries silently. Use when the user says "/optimize", "Cowork is slow", "speed up Cowork", "fix slowness", "Claude is slow", "decrease memory", "decrease tokens", "every prompt takes forever", "Start Up takes too long", or any complaint about per-prompt latency. Also use as the v0.9 migration path for users who installed before v0.9.0. Plan-then-approve — never edits files without showing the diagnosis and waiting for "yes".
---

# /optimize — Speed up a slow Cowork

You diagnose what's making the user's Cowork slow per prompt, propose fixes, wait for "yes", then apply them. Everything is reversible via `rollback`.

The two things that slow Cowork down per prompt:

1. **Pre-v0.9 handbook directive.** The old `claude.md` template (≤ v0.8.x) contained a line telling Claude to *"read every file in `about-me/` before responding to my first message."* Claude follows this literally on every turn, doing 5–7 file reads before answering. Removing it kills 90% of the "Start Up" latency.
2. **Bloated `about-me/memory.md`.** Append-only with no rotation. After months of daily use it grows to 5,000+ tokens, all of which get loaded by skills that read recent context.

This skill fixes both. Evergreen — students can run it any time their Cowork starts feeling slow.

---

## The flow — execute in this exact order

### Step 1 — DIAGNOSE

Read these files (silently — don't show contents to user):

1. Workspace `claude.md` (the user's current handbook).
2. `about-me/memory.md`.

Check for these signals:

- **Old handbook directive present?** Search the workspace `claude.md` for the literal string `read every file in about-me/`. If found → flag `OLD_HANDBOOK = true`.
- **Memory overflow?** Count `### YYYY-MM-DD` entries in `about-me/memory.md`. If >30 → flag `MEMORY_OVERFLOW = <count>`. Also flag if the oldest entry is more than 30 days old.
- **memory-log.md exists?** Check if `about-me/memory-log.md` exists. If not and overflow detected → it'll be created during fix.

If neither flag is set → tell the user: *"Your Cowork setup looks healthy. Handbook is clean and memory is at <N> entries (under 30). Nothing for me to optimize right now. If Cowork still feels slow, it might be a network issue or an MCP connector handshake — not the workspace."* End cleanly.

If at least one flag is set → continue to Step 2.

---

### Step 2 — REPORT

Show the user a short diagnosis in plain English. Examples:

> "Here's what I found:
> - **Old handbook directive detected.** Your Global Instructions contain a line that tells Claude to re-read your whole `about-me/` folder on every prompt. That's the main cause of the slow startup. **This is the bug.**
> - **Memory has 47 entries.** I'll archive the oldest 17 to a separate `memory-log.md` file (still keeping the full history — nothing gets lost) so the file Claude reads on each session stays small.
>
> Total estimated improvement: ~20 seconds shaved off per-prompt 'Start Up' time.
>
> Want me to fix these? (**yes** / **no**)"

Tailor the wording to what's actually flagged — don't mention the handbook fix if `OLD_HANDBOOK` is false; don't mention archiving if `MEMORY_OVERFLOW` is false.

Wait for `yes` or `no`.

If `no` → stop cleanly. Append a one-line note to memory.md: `### YYYY-MM-DD — /optimize diagnosed but user declined fix`.

If `yes` → continue.

---

### Step 3 — SNAPSHOT (always, before any change)

Create `_aibos/backups/` if it doesn't exist.

Copy:
- workspace `claude.md` → `_aibos/backups/claude-md-pre-optimize-YYYY-MM-DD-HHmm.md`
- `about-me/memory.md` → `_aibos/backups/memory-pre-optimize-YYYY-MM-DD-HHmm.md`

Tell the user: *"Backed up your current `claude.md` and `memory.md` to `_aibos/backups/`. If anything looks wrong after the fix, type `rollback` and I'll restore them."*

---

### Step 4 — REWRITE THE HANDBOOK (only if `OLD_HANDBOOK = true`)

Read the user's existing `claude.md`. Extract their answers from each section:

- **Who I am** — name, role, location, business, elevator pitch.
- **How to work with me** — tone, length, format, questions, spelling.
- **Things to never do** — their bullets (keep them as written; don't paraphrase).
- **Safety rules** — their bullets.
- **The three things I care about most** — their three priorities.

**Discard entirely:** the `## Things to always do` section. That's the section with the bug. Do not migrate any of its bullets.

Read the new slim handbook template from `~/.claude/plugins/cowork-ai-os/skills/onboard/templates/claude-md.md`. Fill in the extracted answers in the corresponding sections. The new template has a `## Where my identity lives` section between `## How to work with me` and `## Things to never do` — that's a fixed string, not a placeholder, leave it as-is from the template.

Save the result to workspace `claude.md` (overwrites the old one).

---

### Step 5 — GUIDED PASTE (only if `OLD_HANDBOOK = true`)

Cowork doesn't let plugins write Global Instructions directly. The user has to paste it. Show them the new handbook as a single copy-friendly code block:

> "I've rewritten your handbook to remove the per-turn re-read directive. Your answers (name, tone, priorities, etc.) are preserved.
>
> **Copy this block:**
>
> ```
> [paste the full contents of the new claude.md here, as a code block]
> ```
>
> Then:
> 1. Open **Cowork → Settings → Cowork → Global instructions**.
> 2. Click Edit. **Select all the existing text and replace it** with what you just copied.
> 3. Click Save.
>
> Tell me **done** when the new handbook is saved."

Wait for `done`.

---

### Step 6 — ARCHIVE MEMORY OVERFLOW (only if `MEMORY_OVERFLOW` flag set)

Silent. Don't narrate this step — the user doesn't need to think about it.

1. Read `about-me/memory.md`. Parse all entries by their `### YYYY-MM-DD —` headers.
2. Sort chronologically (oldest first).
3. Keep the most recent 30 entries in `memory.md`.
4. Move the older entries (everything beyond 30) to `about-me/memory-log.md`:
   - If `memory-log.md` doesn't exist → create it using the template at `~/.claude/plugins/cowork-ai-os/skills/onboard/templates/memory-log.md` and append the archived entries chronologically (oldest at top, in the existing order).
   - If `memory-log.md` exists → append the archived entries at the bottom (newest of the archived batch is the most recent thing in the archive).
5. Rewrite `memory.md` with only the 30 most recent entries, preserving the header and rules sections.

---

### Step 7 — VERIFY

After all changes:

- Count tokens (approximate: words × 1.3) in workspace `claude.md`. If >350 → something is off (probably extraction pulled too much text). Tell the user: *"Heads up — the new handbook is a bit larger than expected (~X tokens). That's still way better than v0.8 but if you want, type `trim handbook` and I'll suggest specific lines to cut."*
- If `memory.md` still has >30 entries → the archive step failed. Report: *"Memory archive didn't complete. I'll retry — type `retry archive`."*

If both checks pass → continue.

---

### Step 8 — LOG + CLOSE

Append a single entry to `about-me/memory.md` (then re-check the 30-entry cap; if appending pushed it back over 30, archive the new oldest entry too):

```
### YYYY-MM-DD — /optimize run
- **What we worked on:** Cleaned up the workspace for speed.
- **Files touched:** claude.md (handbook), about-me/memory.md, about-me/memory-log.md (if created/extended).
- **Decisions I made:** [List which fixes were applied: handbook rewrite, memory archive of N entries, or both.]
- **Open loops:** None.
- **Next time, do:** Send a quick test prompt to confirm Cowork feels fast again.
```

Then say:

> "Done.
> - [If handbook was rewritten:] Your Global Instructions are now slim and Claude won't re-read your identity files on every prompt.
> - [If memory was archived:] Archived **<N>** older memory entries to `about-me/memory-log.md`. Your full history is preserved.
>
> **Test it:** send any short prompt right now. 'Start Up' should be under 3 seconds. If it still feels slow, or anything looks wrong, type **rollback** to undo everything I just did."

End cleanly.

---

## Rollback

If at any point after Step 3 the user types `rollback`:

1. Restore workspace `claude.md` from the most recent `_aibos/backups/claude-md-pre-optimize-*.md`.
2. Restore `about-me/memory.md` from the most recent `_aibos/backups/memory-pre-optimize-*.md`.
3. If a `memory-log.md` was created during this run (didn't exist before), delete the entries that were just added — or, if `memory-log.md` was created from scratch by this run only, delete the file.
4. Tell the user: *"Rolled back. Your `claude.md` and `memory.md` are back to how they were 5 minutes ago. Note: you'll still need to manually paste the old handbook back into Cowork Settings → Global instructions — I can't write Global Instructions directly."*

If they want to do that, show them the contents of the restored `claude.md` as a copy-friendly code block.

---

## Edge cases

**User's old `claude.md` doesn't follow the v0.8 template structure.** They've heavily edited it. Don't try to extract sections you can't reliably identify. Instead, show them the new slim template (empty) and walk through transferring their answers manually. Don't silently lose their customizations.

**User runs `/optimize` on a fresh v0.9 install (no old directive, memory under 30).** Already handled in Step 1 — say "looks healthy" and stop. Don't pretend to fix something that isn't broken.

**The new handbook would still be over 350 tokens after migration** (because the user wrote multi-paragraph answers in `## How to work with me`). Don't truncate their content. Tell them the new handbook is fine but their tone description is unusually long, and offer to help them trim it.

**User types `done` in Step 5 but Cowork is still showing the old handbook in Settings** (they forgot to actually paste, or pasted in the wrong field). The user can't tell us this directly. Trust their `done` — they'll discover the issue when they test in Step 8. If they say "it's still slow," ask them to re-confirm they pasted into **Cowork → Settings → Cowork → Global instructions** specifically.

**Plugin update hasn't been applied yet** (user is on v0.8 plugin but running an old `/optimize` from an even-older copy somehow). Not really possible since this skill ships with v0.9, but if the user reports the skill is missing — tell them to run `/plugin update cowork-ai-os` first.

---

## What this skill explicitly does NOT do

- Touch `about-me/about-me.md`, `business-brain.md`, `writing-rules.md`, `connections.md`, `audit-log.md`, or `brief-preferences.md`. Those are the user's own content and are preserved untouched.
- Modify any file in `projects/` or `outputs/`. In-flight schedules and saved deliverables stay as they are.
- Re-run onboarding. If the user wants that, they can run `/onboard` fresh, but this skill doesn't trigger it.
- Update the plugin itself. The user does `/plugin update cowork-ai-os` separately — `/optimize` only touches their workspace.
- Disconnect or reconfigure MCP connectors (Gmail, Calendar, etc.).
