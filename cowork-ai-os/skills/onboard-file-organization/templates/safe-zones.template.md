# Safe Zones — File Organization Rules

The `/tidy-*` skills load this file BEFORE opening any directory. If a directory is not on the allow-list, the skill does not open it. If a path matches the forbidden list, the skill stops and reports.

This file is the safety model for every file-organization run, forever. Edit carefully. Log every change in the Revision history section at the bottom.

---

## Allow-list

Folders the `/tidy-*` skills MAY read and reorganize within. Files inside an allow-listed folder may be moved between subfolders **inside the same allow-zone**, but never across allow-zones (see Never-leave rule below).

<!-- Replace these examples with your real absolute paths. -->
- `<absolute path to your Downloads folder>` — primary tidy target
<!-- Add more allow-zones below if you want them organizable. Example: -->
<!-- - `/Users/yourname/Desktop/` — secondary tidy target -->

---

## Forbidden list

Folders and patterns that `/tidy-*` skills MUST NEVER touch, even if they appear inside an allow-zone. The forbidden list always wins over the allow-list.

### Default forbidden patterns (apply to every allow-zone)

- `**/.git/` — version control metadata; reorganization corrupts the repo
- `**/.svn/` — version control metadata
- System folders: `/System/`, `/Applications/`, `C:\Windows\`, `C:\Program Files\`, `C:\Program Files (x86)\`

### Cloud-sync folders (default forbidden — moves can trigger sync events with broad blast radius)

<!-- Add the cloud-sync paths that exist on your system. -->
<!-- Mac iCloud: ~/Library/Mobile Documents/com~apple~CloudDocs/ -->
<!-- Windows OneDrive: C:\Users\<you>\OneDrive\ -->
<!-- Mac/Win Dropbox: ~/Dropbox/ -->
<!-- Mac/Win Google Drive: ~/Google Drive/ or G:\My Drive\ -->

### User-specific forbidden subpaths

Folders inside an allow-zone that are still off-limits because they hold sensitive material.

<!-- Examples: -->
<!-- - `<allow-zone>/Tax-Returns/` — tax docs, manually maintained -->
<!-- - `<allow-zone>/Client-Contracts/` — sensitive client materials -->

---

## Never-leave rule

Files moved during a tidy may only be moved **within the SAME allow-zone**. A file in `Downloads/` can be moved to `Downloads/Invoices/`. It can NEVER be moved to `Documents/Invoices/` or any other top-level location.

Tidying is about organization within a folder, not relocation between folders. Cross-folder moves are a workflow decision the user makes manually.

---

## Approval defaults

- **First 4 weekly tidies:** per-file approval for any row classified as low-confidence. High-confidence rows can be approved in bulk via `APPROVE ALL` or via `EDIT [filter]`.
- **After 4 weeks:** user may opt into bulk approval for high-confidence rows (medium/low still get per-file review).
- **Forever:** no "always allow" mode. Every plan requires explicit user approval before execution.

---

## Hard rules (quoted from user)

> "<user's verbatim 'never delete' quote, captured during onboarding Section D2>"

If the user says "STOP" at any time during a tidy run, the skill halts immediately, reports what it had done so far, and waits for further instruction.

---

## Skill-specific allow-zones (for cross-skill coordination)

Some skills (e.g. a future `/second-brain`) may need write access to a folder outside the standard allow-list. Such carve-outs are listed here, scoped to the specific skill.

<!-- Example: -->
<!-- - `/Users/yourname/SecondBrain/` — scoped to /second-brain skill ONLY. /tidy-downloads must not touch. -->

---

## Revision history

- `<ISO date>` — Created. Phase 1 of `/onboard-file-organization`.

<!-- Append a one-line dated entry whenever this file changes. -->
