# Phase 1 — Declare Safe Zones

**Goal:** Interview the user, write `projects/file-organization/safe-zones.md`. This file is the safety model for every future tidy.

**Time:** ~15 minutes (25 if user needs to explore their filesystem).

---

## The principle to state up-front

Before asking questions, tell the user:

> *"This phase is the most boring-sounding, most load-bearing one in the project. The file we're about to build is the FENCE. Every tidy reads this file before opening any folder. If a folder isn't on the allow-list, I won't touch it. If a folder is on the forbidden list, I stop the run and report.*
>
> *I'm going to ask 5 short sections of questions. One question at a time. If you're unsure, I'll offer a safe default. Be specific — abstract answers like 'don't touch sensitive stuff' don't work. Real paths only."*

---

## Section A — Allow-list (folders you may organize)

### A1
*"What's the single folder you most want cleaned up first? This will be your primary allow-zone. Default suggestion: your Downloads folder."*

If user says "Downloads," capture the exact absolute path:
- Mac: `/Users/<username>/Downloads/`
- Windows: `C:\Users\<username>\Downloads\`
- Linux: `/home/<username>/Downloads/`

If user names something else, capture and verify the path exists.

### A2
*"Any additional folders I should be allowed to organize? Common options: Desktop, a `Screenshots/` folder, `~/Pictures/Imports/`. Default: keep the allow-list to just Downloads for now — we can add more after the first successful tidy."*

Record each as an absolute path. Verify each exists on disk before adding.

---

## Section B — Forbidden list (folders I must NEVER touch)

### B1
*"Anything that contains `.git/` or other version-control metadata in or underneath it. Am I correct that these are categorically off-limits?"*

Default: yes. Add `.git/` and `.svn/` as catch-all forbidden patterns.

### B2
*"Cloud-sync roots — iCloud Drive, OneDrive, Dropbox, Google Drive. Should any of these be off-limits by default?"*

Default: ALL cloud-sync folders are off-limits unless the user explicitly allow-lists one. Find and add literal paths:
- Mac iCloud: `~/Library/Mobile Documents/com~apple~CloudDocs/`
- Windows OneDrive: `C:\Users\<username>\OneDrive\` (and any per-tenant variant)
- Mac/Win Dropbox: `~/Dropbox/`
- Mac/Win Google Drive: `~/Google Drive/` or `G:\My Drive\`

Detect which cloud-sync tools are installed by listing common paths and reporting which exist.

### B3
*"Are there any project folders, financial folders, or sensitive-document folders inside otherwise-safe allow-zones that need to be explicitly protected? For example: 'Downloads is fine to touch, but never touch `Downloads/Tax-Returns/`.' List specific paths."*

If the user is unsure, offer:

> *"Want me to list the subfolders inside your Downloads folder so you can pattern-match? For each one, I'll tell you the approximate purpose based on file types inside. You'll tell me which to add to the forbidden list."*

If user says yes: list `Downloads/` subfolders, infer purpose from file extensions inside each.

---

## Section C — The "never leave" rule

### C1
*"Confirm the rule: files moved during a tidy may only be moved within the SAME allow-zone — e.g. from `Downloads/` to `Downloads/Invoices/`. They may NEVER be moved across allow-zones, e.g. from `Downloads/` to `Documents/`. Do you want to relax this rule for any specific case?"*

Default: do not relax. If the user wants files moved between top-level folders, they do it manually after tidy.

---

## Section D — Approval defaults

### D1
*"For the first 4 weekly tidies, I strongly recommend per-file approval for any row I'm uncertain about (low-confidence classifications). After 4 weeks of successful runs, you can opt into 'approve the whole plan' for high-confidence rows. Confirm: per-file approval on uncertain rows for the first month."*

Default: yes.

### D2
*"I will NEVER delete a file. Do you want to explicitly confirm this rule by typing 'never delete, ever, no exceptions' so it's recorded in your own voice in the file?"*

Capture verbatim — quote it back to the user before saving. This direct quote is load-bearing for future tidies.

---

## Section E — Emergency stop

### E1
*"If you ever say the word 'STOP' in a message during a tidy, I'll halt immediately, report what I'd done so far, and wait for further instruction. Acknowledge this — I'll record it as a rule in `safe-zones.md`."*

User confirms.

---

## Write the safe-zones.md file

After all sections answered:

Use `templates/safe-zones.template.md` as the structure. Fill in real paths from the user's answers. Show the draft in a code block before saving. Ask the user to verify, edit if needed, then save.

Required sections in the file (in this order):

1. **H1**: "Safe Zones — File Organization Rules"
2. **Intro paragraph**: *"The /tidy-* skills load this file BEFORE opening any directory. If a directory is not on the allow-list, the skill does not open it. If a path matches the forbidden list, the skill stops and reports."*
3. **H2 "Allow-list"** — bulleted absolute paths
4. **H2 "Forbidden list"** — bulleted absolute paths and patterns, with a short reason per entry
5. **H2 "Never-leave rule"** — verbatim wording
6. **H2 "Approval defaults"** — per-file on uncertain (current setting)
7. **H2 "Hard rules (quoted from user)"** — including the "never delete" quote and the STOP rule
8. **H2 "Revision history"** — one-line dated entry: *"Created [date]. Phase 1 of /onboard-file-organization."*

---

## Verification before advancing

Two checks. Run both. Do not advance to Phase 2 until both pass.

### Check 1 — Specific paths, not categories

Open `safe-zones.md`. Every allow-list and forbidden-list entry must be a real path (e.g. `C:\Users\nunot\Downloads\` or `/Users/nuno/Downloads/`), not a category in prose ("my Downloads folder").

If entries are abstract → fix:

> *"The entries are reading like categories instead of real paths. Let me rewrite each as the exact absolute path on your system."*

### Check 2 — "Never delete" quote present

Scroll to "Hard rules (quoted from user)". Confirm the literal text the user provided in D2 is present as a quoted line attributed to them.

If the quote is missing → fix:

> *"The 'never delete' quote from D2 didn't make it in. Adding it now under 'Hard rules (quoted from user)' — this line is load-bearing for every future tidy."*

---

## Update state and preview Phase 2

Once both verifications pass:

1. Update `_aibos/state-file-organization.md`:
   - `current_phase: 2`
   - `safe-zones.md: true`
   - `Phase 1 (declare safe zones): completed at <ISO timestamp>`
2. Append to `projects/file-organization/memory.md`: *"Phase 1 complete. safe-zones.md created with N allow-list entries and M forbidden entries."*
3. Tell user:

> *"Phase 1 done. Your safety fence is up.*
>
> *Phase 2 next: I'll show you the verbatim safety constraints baked into the `/tidy-downloads` skill (so you know exactly what you're trusting), then we'll dry-run the skill on a tiny test folder. The dry-run produces a plan, you reject it, and we verify zero files moved. About 20 minutes.*
>
> *Type `continue onboarding` when ready."*
