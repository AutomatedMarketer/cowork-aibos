# Phase 3 — First Live Tidy

**Goal:** Run `/tidy-downloads` against the user's real allow-zone (typically Downloads). Read the plan carefully. Execute approved rows. Verify before/after counts. Walk `_review/` once. Zero deletions, zero moves outside the allow-zone, every move accounted for.

**Time:** ~25 minutes (40 min if Downloads has 500+ files).

---

## Script — what to say (in voice)

> *"Phase 3 is the real one. We'll run the tidy on your actual Downloads folder. The plan from this run will move dozens or hundreds of real files.*
>
> *Big rule for today: don't APPROVE ALL on the first run. Use EDIT, with at minimum the low-confidence filter. Read the plan like a contract you're about to sign. The first run is slow on purpose — it teaches you what 'low confidence' actually looks like, and it teaches the skill which patterns you correct.*
>
> *Three things to do before we run:*
>
> *1. Close any apps actively writing to Downloads (browser downloads in progress, Slack downloading files, etc.).*
> *2. We'll remove the temporary `_test-tidy` entry from `safe-zones.md` so it doesn't linger. The test folder served its purpose.*
> *3. If your Downloads has 2000+ files, expect the scan to take 10–15 minutes.*
>
> *Type `let's run it` when ready."*

---

## Step 1 — Pre-flight cleanup

Remove the temporary `_test-tidy` allow-list entry from `safe-zones.md`. Append a Revision history entry: *"Removed temporary _test-tidy entry. /onboard-file-organization Phase 3 cleanup."*

Also delete the `_test-tidy/` folder itself from the workspace (the user can do this manually or you can offer):

> *"Want me to delete the `_test-tidy/` folder? It's the only folder I'll ever delete in this entire system, and only because you and I both created it ten minutes ago and it's named `_test-`. Yes / no?"*

If yes, delete the empty test folder. (This is a workspace operation, not a `/tidy-downloads` operation — `/tidy-downloads` itself never deletes any file other than its own rejected plan.)

---

## Step 2 — Run the SCAN + PLAN phase

Run `/tidy-downloads` with no arguments — defaults to the first allow-zone (typically Downloads).

The skill should:

1. LOAD `safe-zones.md`. Confirm `_test-tidy` entry is gone.
2. Target the user's first allow-zone (e.g. Downloads).
3. Scan one level deep.
4. Classify each file.
5. Write the plan to `projects/file-organization/plans/tidy-plan-YYYY-MM-DD-HHmm.md`.
6. Report totals.

**STOP at Step 6. Do NOT execute.**

Tell the user:

> *"Plan written. Totals: [N files scanned, M moves proposed, K flagged for review]. Largest destination buckets: [top 3].*
>
> *Before you read the plan file, here are the 5 rows I'm least confident about — review these carefully:*
>
> *[List 5 lowest-confidence rows: filename + proposed destination + why uncertain]*
>
> *Open the plan file at `projects/file-organization/plans/[filename]` and read every row. When you're ready, reply with one of:*
> *- `EDIT low-confidence only` (recommended for first run)*
> *- `APPROVE ALL` (not recommended for first run)*
> *- `REJECT` (cancel, no files move)*
> *- A targeted instruction (e.g. 'reject any row moving to _review/unknown', 'keep original filenames for any row whose name contains FINAL or REAL')"*

---

## Step 3 — Surface red flags as the user reads

While the user reads, proactively flag any row that matches a known red-flag pattern:

- A file moving into a category that surprises (e.g. a contract going into Data-exports)
- A rename that strips information (filename containing "FINAL", "REAL", or version numbers being lost)
- A file the user mentioned earlier as actively in use
- Proposed duplicates that may actually be different files with similar names
- Rows targeting `_review/unknown/` for files with a clear type — Claude got confused; offer to override

For each red flag, present:

> *"Row [N]: `[original filename]` → `[proposed]`. Heads-up: [reason this might be wrong]. Want me to: (a) keep this in the plan, (b) reject this row, (c) change destination to [suggestion]?"*

---

## Step 4 — Execute approved rows

Once the user gives an approval instruction:

- For `EDIT low-confidence only`: walk each medium/low-confidence row one at a time. Show: filename, first 100 chars of content (text) or EXIF (image), proposed destination, confidence, reason. User responds approve / reject / change-to. High-confidence rows execute without per-row review unless user says otherwise.
- For `APPROVE ALL`: discourage on first run, but if user insists, execute every row.
- For `REJECT`: delete the plan, log rejection, exit. No files moved.

For each approved row, MOVE the file to the new path. Verify the move by reading the destination path. If a move fails (lock, permission, collision), log the failure and continue with remaining rows. Do NOT retry aggressively.

Permission prompts: on the first real run, expect Allow prompts per move (depending on Co-Work settings). Don't tell the user to flip on "Always Allow" — the prompts are the trust model working.

---

## Step 5 — Write the receipt

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

Show the receipt entry to the user before saving.

---

## Step 6 — VERIFY (the 4-check report)

After execution completes, generate a verification report. Tell the user:

> *"Time for the verification. Four checks. All four must pass before we call this done."*

### VERIFY 1 — File counts reconcile

Compare files in the allow-zone before vs. after. The total count must be IDENTICAL (every file is now either in a new subfolder, in `_review/`, or stayed in place if not in the plan).

If counts don't match → **STOP and investigate.**

> *"File count mismatch: [X before] vs [Y after]. [Z] files unaccounted for. I'm going to audit the receipt — for every row in the plan, I'll tell you where that file is now. Stand by."*

### VERIFY 2 — Destination subfolders populated

Open each destination subfolder (`Invoices/`, `Screenshots/`, `Reports/`, etc.) and confirm files actually landed there.

### VERIFY 3 — `_review/` walked

Open `_review/unknown/` and `_review/duplicates/`. Tell the user what's in each and why.

### VERIFY 4 — Zero deletions confirmed

The count of files in the allow-zone before MUST equal the count after (excluding new subfolders we created). Confirm explicitly.

If VERIFY 4 fails (file count dropped):

> *"CRITICAL. File count dropped by [N]. The tidy should not delete anything. Checking Recycle Bin / Trash, checking `_review/`, checking the receipt for failed-move rows that might have left files in an ambiguous state. Stand by."*

---

## Step 7 — Walk `_review/`

Open `_review/unknown/` with the user. For each file (cap at first 10 for time):

> *"`[filename]` — I wasn't sure where this should go because [reason]. Options: (a) keep as-is in `_review/unknown/`, (b) move to a specific destination, (c) leave for next week's tidy. What do you want?"*

Act on per-file decisions. Don't bulk-resolve.

For `_review/duplicates/`, show each suspected duplicate with the file it's being compared against. User decides: keep both / delete one manually (you don't delete) / keep the older / keep the newer.

---

## Optional — build a reverse-index

Offer:

> *"Want me to build a `downloads-index.md` snapshot — a table of every file currently in your Downloads, with current path + type + date + keywords? Useful for future 'where did I put X?' searches. Regenerated on each weekly tidy. Yes / no / later?"*

If yes, write `projects/file-organization/downloads-index.md`.

---

## Update state and preview Phase 4

Once all four verifications pass:

1. Update `_aibos/state-file-organization.md`:
   - `current_phase: 4`
   - `first live tidy completed: true`
   - `Phase 3 (first live tidy): completed at <ISO timestamp>`
2. Tell user:

> *"Phase 3 done. First real tidy complete. [N] files moved successfully, [K] in `_review/`, [M] decided in the walk-through. Zero deletions. Zero moves outside the allow-zone. Receipt saved.*
>
> *Phase 4 next: the schedule. We'll wire `/tidy-downloads` to fire automatically every [Friday 5pm by default — you can pick a different time]. The scheduled run only PLANS — execution is always your manual approval. We'll also schedule a monthly `_review/` audit and start a 4-week calibration log so the skill gets sharper over time. About 20 minutes. Type `continue onboarding` when ready."*
