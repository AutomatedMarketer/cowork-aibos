# v0.10 audit — existing 12 skills baseline (2026-05-12)

One-time internal audit run during the v0.10 build. Verified each existing skill's body length, description length, and trigger-phrase breadth before adding the two new skills.

## Body length (Anthropic recommendation: <500 lines)

| Skill | Lines | Status |
|---|---|---|
| add-skill | 216 | ✅ |
| audit | 132 | ✅ |
| brief-source-comms | 205 | ✅ |
| level-up | 118 | ✅ (now ~145 after v0.10 sharpening) |
| morning-brief | 140 | ✅ |
| onboard | 119 | ✅ |
| onboard-daily-brief | 147 | ✅ |
| onboard-file-organization | 99 | ✅ |
| optimize | 198 | ✅ |
| tidy-downloads | 241 | ✅ (largest — appropriate for plan-then-approve complexity) |
| tune-up | 229 | ✅ |
| voice-writer | 129 | ✅ |

All 12 skills well within Anthropic's 500-line guidance. No action needed.

## Description length (Anthropic max: 1,024 chars)

| Skill | Chars | Status |
|---|---|---|
| add-skill | 267 | ✅ |
| audit | 289 | ✅ |
| brief-source-comms | 556 | ✅ (helper skill — verbose by design) |
| level-up | 328 | ✅ (now ~580 after v0.10 sharpening) |
| morning-brief | 302 | ✅ |
| onboard | 295 | ✅ |
| onboard-daily-brief | 677 | ✅ |
| onboard-file-organization | 616 | ✅ |
| optimize | 600 | ✅ |
| tidy-downloads | 690 | ✅ |
| tune-up | 317 | ✅ |
| voice-writer | 350 | ✅ |

All under the 1,024 char limit. No action needed.

## Trigger phrase breadth (target: 5+ natural-language triggers per skill)

Spot-check on the 12 existing skills found all have 4–10 trigger phrases. Strongest SEO: `/optimize` (9 triggers), `/tidy-downloads` (7), `/onboard-daily-brief` (10). Weakest but still acceptable: `/level-up` (4 before v0.10 sharpening; now 8 after), `/tune-up` (4). No skill is below the 4 threshold.

## Conclusion

Post-v0.9 architecture is sound. v0.10 adds 2 new skills (`/browse-skills`, `/browse-connectors`) without touching the existing 12 except for the `/level-up` sharpening and the two `/onboard` phase updates (5 and 7).

## v0.10 baseline metadata token estimate (14 skills total)

Measured (sum of description chars × 1.3 / 4 ≈ token cost of all YAML descriptions loaded at session start):

- Total descriptions: **6,994 chars** across 14 skills
- Token estimate: **~2,273 tokens** of always-loaded metadata
- Target was ≤1,800 tokens — **we're ~470 over**

The overage is mostly in three descriptions:
- `/browse-skills` (628 chars) — comprehensive trigger phrases for discoverability
- `/browse-connectors` (715 chars) — comprehensive trigger phrases
- `/level-up` (692 chars after v0.10 sharpening — added 6-form branching context to description)

**Decision: accept the overage.** The value of comprehensive trigger phrases (better marketplace discovery, more natural language coverage) is worth the ~500 extra tokens. Anthropic's spec caps individual descriptions at 1,024 chars — all three are well under that. The total per-prompt overhead (handbook + skill metadata) at cold start is **~2,573 tokens** (300 handbook + 2,273 metadata), still a **~77% improvement over v0.8 (~11,000 tokens)**.

If a future release adds more skills and pushes total metadata past ~2,500 tokens, the priority trim targets in order: `/onboard-daily-brief` (677 chars), `/tidy-downloads` (690 chars), `/browse-connectors` (715 chars). These have the most trimmable trigger lists.

Per-prompt overhead breakdown (v0.10 cold start):
- Slim handbook in Global Instructions: ~300 tokens
- Skill metadata (14 skills): ~2,273 tokens
- **Total: ~2,573 tokens**
- vs v0.8 baseline: ~11,000 tokens — **~77% reduction maintained**
- vs v0.9 baseline: ~1,800 tokens — adds ~470 tokens for the two new discovery skills (net positive given the value)
