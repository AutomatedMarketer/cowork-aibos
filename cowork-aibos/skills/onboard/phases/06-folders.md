# Phase 6 — Folders (workspace structure)

**What this phase does:** Creates the three production folders at the workspace root, plus the `_aibos/` system folder, and updates the handbook with folder-routing rules.

**Time:** 5 minutes
**Output:** `outputs/`, `projects/`, `reference/`, `_aibos/` at workspace root

---

## Step 1 — Greet, set context

Say:

> "Phase 6 of 9: folders. Quick one — about 5 minutes. We're creating four folders inside your workspace so I always know where to save things. Ready? Type **go**."

Wait for `go`.

## Step 2 — Confirm workspace path

Tell the user:

> "First, let me confirm I know where your workspace is."

Read the workspace folder Cowork is pointing at. Show its absolute path. Ask:

> "Is this right? **[path]**. Type **yes** if that's your workspace, or tell me where it should be."

## Step 3 — Create the four folders

Tell the user:

> "I'm going to create four folders at the root of your workspace. They are:
> 
> - **outputs/** — every deliverable I create gets saved here, organized by project
> - **projects/** — per-project briefs, context, and notes
> - **reference/** — read-only reference material (your style guides, brand docs, etc.)
> - **_aibos/** — system files for the AIBOS plugin itself (you don't need to touch these)
> 
> Type **go** to create them."

Wait for `go`. Create all four folders. Confirm each was created.

## Step 4 — Update the handbook with folder rules

Tell the user:

> "Now I'm adding the folder rules to your handbook so I always save things in the right place."

Generate this block:

```markdown
## Folder rules

- All deliverables go to `outputs/<project-name>/YYYY-MM-DD-<short-descriptive-name>.<ext>` — never to the workspace root and never to about-me/.
- If no clear project name, ASK before saving.
- Filenames use `YYYY-MM-DD-short-descriptive-name.ext` format.
- `projects/` holds per-project briefs and memory.
- `reference/` is read-only — don't write to it without explicit permission.
- `_aibos/` is for AIBOS plugin state only — don't touch unless I tell you to.
```

Show this block to the user. Tell them:

> "Open Cowork → Settings → Cowork → Global instructions → Edit. Add this block at the bottom. Click Save. Tell me when done."

Wait for confirmation. Then update the workspace `claude.md` backup to match.

## Step 5 — End-to-end test

Tell the user:

> "Let's verify the rules work. In a fresh Cowork task, type: **'Create a one-paragraph test document using anything from my business-brain.md.'** I should ask you which project to save it under, then save it to outputs/[project]/YYYY-MM-DD-test-document.md. Tell me when you've run that test and where the file landed."

Wait. If the file lands in the wrong place, the rules didn't load — have them check the handbook saved correctly.

## Step 6 — Log and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 6 complete: folder system created
- **What we worked on:** Created outputs/, projects/, reference/, _aibos/ folders. Added folder routing rules to handbook.
- **Files touched:** Workspace folders, claude.md (handbook + backup), Settings → Cowork → Global instructions.
- **Open loops:** None.
- **Next time, do:** Phase 7 (skills tour).
```

Update state.md.

## Step 7 — Hand off

Say:

> "Phase 6 done. The workspace has structure now. Phase 7 is fun — I show you every AIBOS skill with a tiny live demo, so you know what's available. About 15 minutes. Continue?"
