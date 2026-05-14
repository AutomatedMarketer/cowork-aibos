# v0.10.2 — Live-fetch the Anthropic Directories

## The big idea

Anthropic ships new Cowork connectors weekly. Twenty-plus new legal-vertical connectors landed in May 2026 alone. The catch: every plugin that recommends connectors (including this one until today) bundles a static catalog at release time. By the time the plugin reaches you, the catalog is already a release behind.

v0.10.2 fixes this. `/browse-connectors`, `/browse-skills`, and now `/tune-up` all live-fetch directly from Anthropic's public sources. Recommendations stay current. The bundled catalogs stay in place as the offline-only fallback.

## What's new

- **`/browse-connectors` and `/browse-skills` live-fetch by default.** When you run either, they query Anthropic's public directories first — `claude.com/connectors` for the 200+ Cowork connectors, plus the two GitHub marketplace.json manifests (`anthropics/claude-plugins-official` and `anthropics/skills`) for plugins and first-party skills. They tell you which source the recommendations came from. Bundled catalogs become offline-only fallback.

- **`/tune-up` Gate 3 — "what's new since last tune-up."** Before offering the existing forms, /tune-up now diffs the live directories against your last tune-up date. If Anthropic added 12 connectors in the last week and one matches your business-brain, you'll see it surfaced — without ever having to browse the directory yourself.

- **Cross-reference with what you already have.** `/browse-skills` now reads your `~/.claude/plugins/installed_plugins.json` so it never recommends a plugin you already installed.

- **Caching for offline use.** Live fetches are cached for 24 hours in `_aibos/cache/`. If you go offline, the cache + bundled snapshot keep working.

## Install / upgrade

If you're on v0.10.x already, you'll get v0.10.2 automatically the next time you run `/plugin update cowork-ai-os@cowork-ai-os`.

Fresh install:
```
/plugin install cowork-ai-os@cowork-ai-os
/onboard
```

## Breaking changes

**None.** v0.10.2 is purely additive. The bundled `references/*.md` catalogs are still in place as fallback. /onboard, /level-up, and /tune-up all keep working exactly as before — they just have access to fresher data now.

## What's next

- **v0.10.3 (planned)** — extend the live-fetch pattern to `/level-up` so when it surfaces "add a connector" or "install a skill," it specifically calls out what's NEW vs what's been in the catalog forever.
- **v0.11 (planned)** — integration hooks for the Wave 2 add-on plugins (cowork-research, cowork-financial) so their wizards can call cowork-ai-os's enhanced recommenders directly instead of bundling their own connector catalogs.

## Credits

Live-fetch URLs validated 2026-05-14 against Anthropic's public sources. Built by Nuno Tavares of Automated Marketer.
