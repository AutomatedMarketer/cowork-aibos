# Live-fetch helper for /browse-connectors

> Used by `/browse-connectors` to get the CURRENT list of Cowork-compatible connectors from Anthropic's public directory, instead of relying on the bundled snapshot which goes stale.

## Source

**`https://claude.com/connectors`** — Anthropic's official Cowork Connectors directory. Public (no login required). HTML page with connector cards. ~200+ connectors as of May 2026, refreshed weekly. Verified fetchable on 2026-05-14.

Individual connector detail pages also public:
- `https://claude.com/connectors/<slug>` — e.g. `/connectors/notion`, `/connectors/google-drive`, `/connectors/netdocuments`

## Procedure

### Step 1 — Try live fetch first (preferred path)

Use WebFetch:

```
WebFetch(
  url: "https://claude.com/connectors",
  prompt: "Return a JSON-style list of every connector card visible on this page. For each: name, one-sentence description, category if shown (e.g. Productivity, Communication, Knowledge), and whether the card has a 'New' badge. Return up to the first 80 connectors visible."
)
```

If the fetch succeeds and returns ≥10 connectors, use the result as the LIVE catalog.

### Step 2 — Cache the live result for offline fallback

Append a one-line entry to `about-me/memory.md`:
```
YYYY-MM-DD: /browse-connectors fetched live catalog from claude.com/connectors — N connectors retrieved
```

Optionally, write the parsed live result to `<workspace>/_aibos/cache/connectors-live-cache.md` with a `fetched_at:` timestamp at the top. Future runs within 24 hours can read this cache instead of re-fetching.

### Step 3 — Fallback to bundled catalog if live fails

If WebFetch returns an error, times out, or returns fewer than 10 connectors (suggesting the page changed or fetch was blocked):

1. Tell the user: "Live directory unavailable — using bundled snapshot from <last-update-date> as fallback. May be missing the most recent additions."
2. Read `references/connectors-catalog.md` (the existing bundled snapshot — 25 entries, 7 buckets)
3. Use that as the catalog for the rest of `/browse-connectors`

### Step 4 — Merge cached + live (if both available)

If both the live fetch AND the local cache exist (cache is fresh, <24h), prefer the live result. Use cache only if live fails.

## Why live fetch matters

Anthropic adds connectors weekly (20+ legal-vertical connectors added in May 2026 alone). The bundled `references/connectors-catalog.md` was a snapshot at plugin release time. Without live fetch, we recommend stale lists that miss what's currently most useful.

## Hard rules

- NEVER scrape if the user is offline — always check fetchability before announcing recommendations
- ALWAYS tell the user whether the recommendations came from LIVE or BUNDLED source — transparency builds trust
- NEVER cache for more than 24 hours — staleness is the whole problem we're solving
- The cache file goes in `_aibos/cache/`, never in `about-me/` (cache is per-machine, not identity)
