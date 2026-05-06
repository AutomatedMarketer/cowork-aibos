# Tidy Plan — <target zone> — <ISO timestamp>

**Summary:** <N> files scanned · <M> moves proposed · <K> flagged for review (<L> high · <P> medium · <Q> low confidence)

---

## Top destination buckets

- `<DestSubfolder1>/` — <count>
- `<DestSubfolder2>/` — <count>
- `_review/unknown/` — <count>
- `_review/duplicates/` — <count>

## Lowest-confidence rows (read these carefully)

1. `<filename>` → `<proposed>` — <why uncertain>
2. ...

## Skipped (forbidden subpaths inside the allow-zone)

- `<path>` — matched forbidden rule: <which rule>

---

## Full plan

| Filename (original) | Proposed new path | Reason | Confidence |
| --- | --- | --- | --- |
| <example1.heic> | <Photos/2025-09-14-photo.heic> | <EXIF date + GPS> | high |
| <example2.pdf> | <Invoices/2025-10-20-acme.pdf> | <PDF text "Acme Inc, due 2025-10-20"> | high |
| <example3.jpg> | <_review/unknown/example3.jpg> | <No EXIF, ambiguous filename> | low |

---

## Response options

Reply with one of:

- `APPROVE ALL` — execute every row above
- `REJECT` — cancel; this plan file gets deleted; no files move
- `EDIT` — walk medium/low-confidence rows one at a time
- `EDIT low-confidence only` — walk only the low-confidence rows; high/medium auto-approve
- A targeted instruction, e.g. *"reject any row moving to `_review/unknown`"* or *"keep original filenames for any row whose name contains FINAL or REAL"*

The plan does not execute until you reply. Pause as long as you want.
