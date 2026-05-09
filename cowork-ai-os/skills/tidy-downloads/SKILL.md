---
name: tidy-downloads
description: Plan-then-approve cleanup of an allow-listed folder (Downloads, Desktop, etc.). Triggers on "/tidy-downloads", "tidy my downloads", "clean up downloads", "organize downloads", "sort my downloads", "tidy my desktop", "tidy [folder-name]", or any request to organize/clean/sort files in a specific folder. Reads `projects/file-organization/safe-zones.md` BEFORE opening any directory. Writes a plan to `projects/file-organization/plans/` and waits for explicit user approval. Moves and renames only. Never deletes any file. Never writes outside the target allow-zone. Optional argument `[allow-zone-name]` selects which allow-zone to target; defaults to the first allow-zone in safe-zones.md.
---

# Tidy Downloads — Plan-Then-Approve File Organization

You organize files in an allow-listed folder by **proposing a plan, waiting for approval, then executing only what the user approves.** You do not act in one shot. You do not delete. You do not leave the allow-zone.

## The hard safety constraints — VERBATIM, NEVER PARAPHRASED

> "I must NEVER delete any file in the target folder. If a delete seems justified, I MOVE the file to `_review/duplicates/` or `_review/unknown/` instead."

> "I must NEVER write or move files OUTSIDE the current allow-zone, even into sibling allow-zones."

> "I must NEVER touch any path matching the forbidden list. If the target zone CONTAINS a forbidden subpath, I skip that subpath entirely — including all its contents — and note the skip in the plan."

> "I must ALWAYS write the plan BEFORE executing. I must wait for explicit user approval between plan and execution — no assumptions."

> "If the user says 'STOP' at any time, I halt immediately, report what I had done so far, and wait for instructions."

> "I must NEVER delete MY OWN plan file while it contains approved-but-not-yet-executed actions."

These six rules are the spine of this skill. They are not negotiable, are not relaxed for "trusted" runs, and never go away — not on the first run, not on the hundredth.

The **one exception** to "never delete": when the user explicitly says REJECT on a plan, the skill may delete its own plan file at `projects/file-organization/plans/tidy-plan-*.md`. Nothing has been acted on; keeping a rejected plan around risks later accidental approval. All other file deletes are forbidden.

---

## Step-by-step flow — execute in this exact order, every time

### Step 1 — LOAD safe-zones.md

Read `projects/file-organization/safe-zones.md`.

- If the file is missing, unreadable, or has zero allow-zones → **STOP immediately**. Tell the user: *"`safe-zones.md` is missing or empty. Run `/onboard-file-organization` (Phase 1) to declare your safe zones before I can run a tidy."*
- Parse: allow-list (paths Claude may organize), forbidden list (paths Claude must never touch, even inside an allow-zone), approval defaults, hard rules (quoted from user), STOP rule.

### Step 2 — DETERMINE target allow-zone

- If the user passed an argument (e.g. `/tidy-downloads desktop`), match it against the allow-list. If no match → STOP and list the available allow-zones.
- If no argument → use the first allow-zone in safe-zones.md (typically Downloads).

### Step 3 — VERIFY the target

- Confirm the target path exists on disk. If not → STOP and report.
- Check the forbidden list — if the target path itself matches any forbidden pattern → STOP and report which rule was hit.

### Step 4 — READ the allow-zone (one level deep by default)

Scan files in the target. **Recursive ONE level only** — e.g. `Downloads/` and its immediate subfolders, but not `Downloads/Invoices/2024/...`. This prevents the skill from reorganizing previously-tidied subfolders. Deep scans require an explicit user instruction.

For each file:
- Note: filename, size, modified date.
- Open just enough to determine content type:
  - PDFs → first page text + title metadata
  - Images → EXIF metadata (date taken, GPS, camera) — never pixel data
  - Documents (.docx, .md, .txt) → title + first 500 words
  - Other → filename + size only

The skill does NOT upload files to external services, does NOT index beyond classification need, and does NOT cache contents after the tidy completes.

### Step 5 — CLASSIFY each file

Standard destination subfolders (created inside the allow-zone as needed):
- `Invoices/` — invoices, bills, receipts
- `Screenshots/` — screen captures
- `Photos/` — camera/phone photos with EXIF data
- `Reports/` — quarterly/annual reports, analyses
- `Installers/` — `.dmg`, `.exe`, `.pkg`, `.msi`, app installers
- `Data-exports/` — CSV exports, JSON data dumps, database extracts
- `Contracts-and-signed/` — signed agreements, contracts
- `_review/duplicates/` — files that look like duplicates of another file in the scan
- `_review/unknown/` — low-confidence classifications

**Never invent generic "Misc" bins.** A file matching nothing goes to `_review/unknown/` so the user can decide.

Confidence rule:
- **High** = filename AND content both clearly match a known class
- **Medium** = one signal matches
- **Low** = neither matches; classification is a guess → goes to `_review/unknown/`

### Step 6 — PROPOSE a rename

Rename based on content + date:
- `IMG_4782.HEIC` taken 2025-09-14 → `2025-09-14-photo-paris-streets.heic` (when image metadata has location/scene)
- `acme_invoice_oct.pdf` (PDF dated 2025-10-20, vendor "Acme") → `2025-10-20-acme-invoice.pdf`

Preserve filename information that may be load-bearing (e.g., `_FINAL`, `_REAL`, version numbers a user explicitly added). When unsure, keep the original filename.

### Step 7 — WRITE the plan

Save to `projects/file-organization/plans/tidy-plan-YYYY-MM-DD-HHmm.md`. Format:

```markdown
# Tidy Plan — <target zone> — <ISO timestamp>

**Summary:** <N> files scanned · <M> moves proposed · <K> flagged for review (<L> high · <P> medium · <Q> low confidence)

| Filename (original) | Proposed new path | Reason | Confidence |
| --- | --- | --- | --- |
| IMG_4782.HEIC | Photos/2025-09-14-photo-paris-streets.heic | EXIF date + GPS Paris | high |
| acme_invoice_oct.pdf | Invoices/2025-10-20-acme-invoice.pdf | PDF text "Acme Inc, due 2025-10-20" | high |
| dsc00012.jpg | _review/unknown/dsc00012.jpg | No EXIF, ambiguous filename | low |
```

One row per file. Every row shows where the file will go (or which `_review/` sub-bucket).

### Step 8 — REPORT and WAIT

Tell the user:

> *"Plan written to [path]. Totals: [N files, M moves, K flagged for review]. Open the plan file, review, then reply with `APPROVE ALL` to execute every row, `REJECT` to cancel, or `EDIT` to walk medium/low-confidence rows one at a time."*

Also offer the user a short summary they can read without opening the file:
- Top 3 destination buckets by count
- The 5 files lowest in confidence (filename + proposed destination + why)
- Any rows where the rename would change the file extension or strip filename markers
- Any flagged duplicates (with what they're being compared against)

**WAIT for explicit response.** Do not proceed to any file move without it. Acceptable responses:
- `APPROVE ALL` — execute every row
- `REJECT` — cancel; delete the plan file; log rejection in memory.md
- `EDIT` (optionally with a filter like `EDIT low-confidence only`) — walk rows; per-row decision
- A targeted instruction like *"reject any row moving to `_review/unknown`"* or *"keep original filenames for any row whose original name contains FINAL or REAL"*

### Step 9 — EXECUTE on approval

For each approved row:
1. Create the destination subfolder if it doesn't exist (inside the allow-zone only).
2. MOVE the file (never copy-and-delete) to the new path with the new filename.
3. Read the destination path and verify the file is there. If yes → continue. If no → log the failure and continue with remaining rows. **Do NOT retry aggressively. Do NOT fall back to different behavior.**

Failure modes to log gracefully without aborting the whole run:
- File locked / in use by another process
- Permission denied
- Destination collision (a file with the same name already exists at the destination)

For any failure, the original file stays in place. The skill never leaves a file in an ambiguous state.

### Step 10 — WRITE the receipt

Append to `projects/file-organization/memory.md`:

```markdown
## Tidy at <ISO timestamp>
- **Allow-zone:** <path>
- **Plan file:** <path>
- **Counts:** planned=<N> · approved=<M> · executed=<X> · failed=<F> · rejected-by-user=<R>
- **In _review/:** <K>
- **Failures:** <list with reason per failure>
- **Total runtime:** <duration>
```

The receipt is the audit log — one entry per tidy run, forever.

### Step 11 — On REJECT

- Delete the plan file at `projects/file-organization/plans/tidy-plan-*.md`. (This is the **only** action where deletion is allowed by this skill.)
- Append rejection entry to memory.md: timestamp, plan file path, "REJECTED — no files moved."
- Confirm to user: *"Plan rejected. Nothing moved."*

### Step 12 — On EDIT

Step through each row matching the user's filter. For each row:
- Show: filename, first 100 chars of content (text) or EXIF (image), proposed destination, confidence, reason.
- User responds: `approve` / `reject` / `change-to <path>`.
- Act only on per-row decisions. High-confidence rows skip review unless the user opts to review them too.

Once user is done editing, execute approved rows per Step 9.

---

## Behavior in scheduled (headless) runs

When invoked by a scheduled task (e.g. weekly Friday tidy):

- **Run Steps 1–7 only.** Read, classify, write the plan.
- **Do NOT execute any moves under any circumstance.** "Scheduled auto-execute" is forbidden. Attempting to build it is a critical safety violation.
- After writing the plan, append a notification entry to `projects/file-organization/memory.md`:

```markdown
## PLAN WAITING — <ISO timestamp>
- **Plan:** <path>
- **Totals:** <N> files planned, <K> flagged for review.
- **Action required:** Review the plan and reply with APPROVE / REJECT / EDIT to execute.
```

The user will return on their own time, open Co-Work, see the PLAN WAITING entry, and complete Steps 8–10 manually.

---

## STOP word handling

If the user types `STOP` at any time during a run:
1. Halt immediately. Make no further file system writes.
2. Report what was done so far: which step you were on, what files were already moved (if any), where the plan file is.
3. Wait for further instruction. Do not assume the user wants you to undo, retry, or continue.

---

## Failure modes to handle gracefully

- `safe-zones.md` missing or malformed → STOP at Step 1
- Target allow-zone doesn't exist on disk → STOP at Step 3
- Insufficient permissions to read or move → log per-file, continue
- File locked by another process → log per-file, continue
- Classification failure → row goes to `_review/unknown/`
- Disk full mid-execution → STOP, log, surface to user

In all failure modes, the skill prefers "do less" over "do more aggressive recovery." The user is always the final decision-maker.

---

## What this skill never does

- Delete any file (one exception: its own plan file on REJECT, see Step 11)
- Copy-and-delete (which is logically two operations and looks fine but breaks the never-delete invariant). Always MOVE.
- Move files outside the target allow-zone, even into sibling allow-zones
- Touch any path matching the forbidden list
- Auto-execute on a schedule
- Run on a folder not in the allow-list (Step 1 stops the run if so)
- Read more than one level deep without explicit user instruction
- Cache file contents after the run completes
- Upload files to external services
- Auto-age-out files (e.g. "delete things older than 90 days") — never. Files older than N days stay where they are unless the user manually decides otherwise.

---

## When the skill should refuse

Refuse with a clear message and DO NOT proceed if any of these are true:

- `safe-zones.md` is missing, unreadable, or empty
- Target allow-zone is not in the allow-list
- Target allow-zone path doesn't exist on disk
- The skill is being asked to delete a file (other than its own rejected plan file)
- The skill is being asked to move a file outside the allow-zone
- The skill is being asked to bypass the plan-then-approve flow ("just go do it", "approve everything automatically")

For each refusal, tell the user *why* in one sentence, and point them at the specific rule (safe-zones, never-leave, never-delete, plan-before-execute).
