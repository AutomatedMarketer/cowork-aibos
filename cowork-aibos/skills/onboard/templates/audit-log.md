# audit-log.md — Your AIBOS Score Over Time

Lives in `about-me/audit-log.md`. Every time you run `/audit` or your weekly `/tune-up` fires, a new entry gets appended here.

Don't write this file manually. Just leave it open. Six months in, you'll be able to scroll the file and watch your AI operating system evolve.

---

## Score log

Each entry uses this shape:

```
### YYYY-MM-DD — <triggered by: onboard / tune-up / manual audit>
- **Total:** <0–100>  (delta from last entry: ±X)
- **Context:** <0–25>     — files read, completeness of about-me/
- **Connections:** <0–25> — connectors enabled, buckets covered
- **Capabilities:** <0–25> — skills installed, custom skills built
- **Cadence:** <0–25>     — scheduled tasks running, weekly tune-up firing
- **Top leverage gap:** <one specific thing>
- **Action taken this week:** <what got changed, or "skipped">
```

---

## Example entry (for format reference)

### 2026-05-04 — Triggered by: onboard

- **Total:** 54 (baseline)
- **Context:** 18/25 — about-me/ has 4 of 5 expected files; writing-rules has only 2 samples instead of 3-5.
- **Connections:** 12/25 — Gmail and Calendar enabled (2 of 7 buckets covered).
- **Capabilities:** 14/25 — All AIBOS skills installed; no custom skills built yet.
- **Cadence:** 10/25 — Morning brief scheduled. Weekly tune-up scheduled. No other routines.
- **Top leverage gap:** Connections — only 2 of 7 buckets are reachable. Adding ClickUp (Tasks bucket) would unlock daily-brief task pulls.
- **Action taken this week:** Baseline only — no improvements yet.
