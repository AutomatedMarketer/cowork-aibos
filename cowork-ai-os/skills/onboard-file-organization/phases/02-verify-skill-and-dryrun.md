# Phase 2 — Verify Skill + Dry-Run

**Goal:** Show the user the verbatim safety block in `/tidy-downloads`, then run a dry-run on a tiny test folder. Verify (a) the skill refuses non-allow-listed folders, (b) it produces a plan without executing, (c) REJECT cleans up the plan and moves zero files.

**Time:** ~20 minutes.

---

## Script — what to say (in voice)

> *"Phase 2 builds the trust. Two parts:*
>
> *First: I'm going to show you — in your own chat — the exact wording of the six hard safety rules that govern the `/tidy-downloads` skill. These are baked into the skill, verbatim. They're not negotiable, they're not relaxed for 'trusted' runs, and they never go away. You should read them once so you know what you're trusting.*
>
> *Second: we'll dry-run the skill on a tiny test folder I help you create. The dry-run produces a plan, you reject it, and we verify nothing moved. This is the safety test. If anything weird happens, we stop and fix.*
>
> *Type `let's see the safety block` to start."*

---

## Step 1 — Surface the verbatim safety block

When the user is ready, read `cowork-ai-os/skills/tidy-downloads/SKILL.md` from the plugin folder. Find the section titled "The hard safety constraints — VERBATIM, NEVER PARAPHRASED" and display the six quoted rules to the user — exactly as written, nothing paraphrased, nothing summarized.

Then ask:

> *"Read those once. Any of them surprise you? Any you'd want different?*
>
> *If you want to change the wording, we'd have to update the skill itself — that's not part of the install, but I can flag it for a future plugin update. For now, type `accept the rules` to continue.*
>
> *If you want to keep going as-is, type `accept the rules`."*

If the user wants to change wording, capture the request, save it to `projects/file-organization/memory.md` as a "skill change request," and continue with the existing rules.

---

## Step 2 — Create the test folder

Tell the user:

> *"Now we set up the dry-run. I'll create a folder called `_test-tidy/` inside your Co-Work workspace, and we'll drop a few dummy files in. The skill runs against that folder, produces a plan, you reject — nothing real gets touched.*
>
> *Want me to create the folder and 6 dummy files for you? (Yes / let me create them myself)"*

If yes, create:

- `_test-tidy/` (in workspace root)
- 6 dummy files inside, with messy names that exercise different classifications:
  - `IMG_4782.HEIC` (empty — exercises Photos classification)
  - `Screenshot 2025-11-14 at 12.42.03.png` (empty — exercises Screenshots)
  - `acme_invoice_oct.pdf` (empty — exercises Invoices)
  - `Q3_REPORT_FINAL.docx` (empty — exercises Reports + filename preservation)
  - `installer.dmg` (empty — exercises Installers)
  - `dsc00012.jpg` (empty — exercises low-confidence → `_review/unknown/`)

Ask permission before each write.

---

## Step 3 — Test the refusal (CRITICAL)

This is the most important verification in the entire project.

Run `/tidy-downloads _test-tidy` against the test folder.

The skill SHOULD STOP IMMEDIATELY and report that `_test-tidy/` isn't on the allow-list. Nothing read. Nothing moved. Nothing planned.

Tell the user:

> *"That refusal is the safety model working correctly. The skill won't open ANY folder that isn't explicitly on your allow-list — even the dummy folder we just made. If it had proceeded, we'd have a critical safety bug to fix before going further.*
>
> *Now we'll temporarily allow-list `_test-tidy/` so the dry-run can actually run. We'll remove the temporary entry at the end of Phase 3."*

### If the skill DID NOT refuse

This is a critical safety failure. Stop the entire onboarding. Tell the user:

> *"CRITICAL SAFETY FAILURE. `/tidy-downloads` proceeded against a folder not on your allow-list. This means the skill's first step — loading and enforcing `safe-zones.md` — is broken in your install. Don't run this skill on any real folder until we fix.*
>
> *Possible causes: (a) `safe-zones.md` got corrupted between Phase 1 and now, (b) plugin install is incomplete, (c) skill loaded an older cached version. Re-read `safe-zones.md` and report what you see, then re-run the test."*

Do not advance until refusal works.

---

## Step 4 — Temporarily allow-list `_test-tidy/`

Open `safe-zones.md`. Append a new entry to the allow-list:

```
- `<absolute path>/_test-tidy/` — TEMPORARY, remove after Phase 3
```

Save. Update the Revision history section with today's date and the note "added temporary _test-tidy entry for /onboard-file-organization Phase 2 dry-run."

---

## Step 5 — Dry-run (real this time)

Run `/tidy-downloads _test-tidy`. The skill should:

1. LOAD `safe-zones.md` (now passes — `_test-tidy/` is allow-listed)
2. SCAN the 6 dummy files
3. CLASSIFY each into a destination subfolder
4. PROPOSE renames where applicable
5. WRITE the plan to `projects/file-organization/plans/tidy-plan-YYYY-MM-DD-HHmm.md`
6. REPORT totals + summary
7. WAIT for approval

**STOP at Step 7. Do NOT execute.**

Show the plan file contents to the user. Verify:

- The plan has the right structure (H1 with timestamp, summary line, table with Filename | Proposed new path | Reason | Confidence)
- One row per dummy file (6 rows total)
- Confidence flags are reasonable
- No row proposes a destination outside the allow-zone
- No row proposes a delete

---

## Step 6 — REJECT the plan

Tell the skill: `REJECT`.

The skill should:
1. Delete the plan file at `projects/file-organization/plans/tidy-plan-*.md` (the one exception to never-delete)
2. Append a rejection entry to `projects/file-organization/memory.md`
3. Confirm: *"Plan rejected. Nothing moved."*

---

## Step 7 — Verify

Three checks. All must pass.

### Check 1 — `_test-tidy/` unchanged

Open `_test-tidy/` in File Explorer / Finder. The 6 dummy files should be EXACTLY as you put them in Step 2. No new subfolders. No renames. Nothing.

### Check 2 — Plan file deleted

Open `projects/file-organization/plans/`. The plan file from Step 5 should be gone (the only deletion this skill is allowed to do).

### Check 3 — Memory log entry

Open `projects/file-organization/memory.md`. There should be a new entry: *"Phase 2 dry-run: plan generated for `_test-tidy/`, rejected. Zero files moved."*

If any check fails:

> *"[Specific failure]. The dry-run safety model didn't behave as expected. We don't proceed to Phase 3 (real tidy) until this is fixed. Tell me what you see in [check that failed] and we'll diagnose."*

---

## Update state and preview Phase 3

Once all three checks pass:

1. Update `_aibos/state-file-organization.md`:
   - `current_phase: 3`
   - `_test-tidy folder created: true`
   - `_test-tidy temporary allow-list entry: true`
   - `Phase 2 (verify skill + dry-run): completed at <ISO timestamp>`
2. Tell user:

> *"Phase 2 done. The skill refuses non-allow-listed folders. The plan-then-approve flow works. REJECT cleans up cleanly.*
>
> *Phase 3 next: the real one. We run `/tidy-downloads` against your real Downloads folder for the first time. This is where the muscle memory comes in — read the plan like a contract, approve carefully, watch the verification report. About 25 minutes (longer if your Downloads has 500+ files).*
>
> *Before we do, close any apps that are actively writing to Downloads (browser downloads in progress, Slack downloading files). Ready when you are.*
>
> *Type `continue onboarding` when ready."*
