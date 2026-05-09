# Safe Zones — File Organization Rules

The `/tidy-*` skills load this file BEFORE opening any directory. If a directory is not on the allow-list, the skill does not open it. If a path matches the forbidden list, the skill stops and reports.

This file is the safety model for every file-organization run, forever. Edit carefully. Log every change in the Revision history section at the bottom.

---

## Allow-list

- `/Users/sarah/Downloads/` — primary tidy target
- `/Users/sarah/Desktop/` — secondary; runs via `/tidy-downloads desktop`

---

## Forbidden list

### Default forbidden patterns

- `**/.git/` — version control metadata; reorganization corrupts the repo
- `**/.svn/` — version control metadata
- System folders: `/System/`, `/Applications/`, `/Library/`

### Cloud-sync folders (default forbidden — moves can trigger sync events with broad blast radius)

- `~/Library/Mobile Documents/com~apple~CloudDocs/` — iCloud Drive root
- `~/Dropbox/` — Dropbox sync root
- `~/Google Drive/` — Google Drive client root

### User-specific forbidden subpaths

- `/Users/sarah/Downloads/Tax-Returns/` — tax docs, manually maintained, never auto-moved
- `/Users/sarah/Downloads/Client-Contracts/` — signed agreements, not for re-categorization
- `/Users/sarah/Desktop/Active-Project-Workspace/` — current client project; touching it breaks build paths

---

## Never-leave rule

Files moved during a tidy may only be moved **within the SAME allow-zone**. A file in `Downloads/` can be moved to `Downloads/Invoices/`. It can NEVER be moved to `Documents/Invoices/` or any other top-level location.

Tidying is about organization within a folder, not relocation between folders. Cross-folder moves are a workflow decision Sarah makes manually.

---

## Approval defaults

- **First 4 weekly tidies (May 2026 → June 2026):** per-file approval for any low-confidence row. High-confidence rows approved via `APPROVE ALL` or `EDIT`.
- **From July 2026:** Sarah may opt into bulk approval for high-confidence rows; medium/low still per-file.
- **Forever:** no "always allow" mode.

---

## Hard rules (quoted from user)

> "never delete a file, ever, no exceptions — if you think a file should be deleted, move it to _review and let me decide"
> — Sarah, 2026-05-06

If Sarah says "STOP" at any time during a tidy run, the skill halts immediately, reports what it had done so far, and waits for further instruction.

---

## Skill-specific allow-zones (for cross-skill coordination)

(none yet — Sarah hasn't installed second-brain or other skills that need carve-outs)

---

## Revision history

- 2026-05-06 — Created. Phase 1 of `/onboard-file-organization`.
- 2026-05-06 — Added temporary `_test-tidy/` entry for Phase 2 dry-run.
- 2026-05-06 — Removed temporary `_test-tidy/` entry post-Phase 3 cleanup.
