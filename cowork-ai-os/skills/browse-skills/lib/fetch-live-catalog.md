# Live-fetch helper for /browse-skills

> Used by `/browse-skills` to get the CURRENT list of available Claude plugins + skills from Anthropic's public marketplaces, instead of relying on the bundled snapshot which goes stale.

## Sources (two fetched in parallel)

### Source 1 — Claude Code plugins (canonical manifest)

**URL:** `https://raw.githubusercontent.com/anthropics/claude-plugins-official/refs/heads/main/.claude-plugin/marketplace.json`

JSON, ~94.8 KB, schema-validated. Contains 100+ plugins across dev/databases/security/productivity/monitoring/deploy/design/data, plus a separate `external_plugins` section for partner plugins. Refreshed continuously by Anthropic.

### Source 2 — Anthropic first-party skills

**URL:** `https://raw.githubusercontent.com/anthropics/skills/refs/heads/main/.claude-plugin/marketplace.json`

JSON. Contains Anthropic's 3 first-party skill packs (document-skills, example-skills, claude-api) covering 17 skills total.

Both verified public (no login) on 2026-05-14.

## Procedure

### Step 1 — Try live fetch (BOTH sources, in parallel)

Use WebFetch for each:

```
WebFetch(
  url: "https://raw.githubusercontent.com/anthropics/claude-plugins-official/refs/heads/main/.claude-plugin/marketplace.json",
  prompt: "Parse this marketplace.json and return a list of every plugin entry. For each: name, description, category (if present), and whether it lives under 'plugins' or 'external_plugins'. Limit to the first 80."
)
```

```
WebFetch(
  url: "https://raw.githubusercontent.com/anthropics/skills/refs/heads/main/.claude-plugin/marketplace.json",
  prompt: "Parse this marketplace.json and return a list of every plugin and the skills it contains."
)
```

If both succeed, merge into a single LIVE catalog.

### Step 2 — Cache for offline fallback

Append a one-line entry to `about-me/memory.md`:
```
YYYY-MM-DD: /browse-skills fetched live catalog (claude-plugins-official + anthropic-skills) — N+M entries retrieved
```

Optionally write parsed result to `<workspace>/_aibos/cache/skills-live-cache.md` with `fetched_at:` timestamp.

### Step 3 — Fallback to bundled catalog if live fails

If either fetch errors out:

1. Tell the user: "Live marketplace unavailable — using bundled snapshot from <last-update-date>."
2. Read `references/skills-catalog.md` (the existing bundled snapshot — 19 entries)
3. Use that as the catalog

### Step 4 — Cross-reference with what user already has installed

Before recommending, read `~/.claude/plugins/installed_plugins.json` (filesystem readable on Claude Code installations). For each candidate, mark "✓ already installed" so we don't recommend duplicates.

## Why two sources

`anthropics/skills` is Anthropic's first-party authored skills (document creation, frontend-design, mcp-builder, etc.).
`anthropics/claude-plugins-official` is the broader marketplace including community + partner plugins (firecrawl, playwright, github, supabase, vercel, etc.).

Together they cover the full Claude Code installable surface. A user might want skills from either.

## Hard rules

- NEVER cache for more than 24 hours
- ALWAYS tell the user whether recommendations came from LIVE or BUNDLED
- ALWAYS check installed_plugins.json so you don't recommend something they already have
- The cache file goes in `_aibos/cache/`, never in `about-me/`
