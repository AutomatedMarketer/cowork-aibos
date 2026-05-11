<div align="center">

# Cowork AI OS — AI Operating System for Claude Cowork

**Build your personal AI Operating System inside Claude Cowork. One install. ~2 hours. Pays back every weekday morning, forever.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.8.0-brightgreen.svg)](https://github.com/automatedmarketer/cowork-ai-os/releases/latest)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows-lightgrey.svg)](#install)
[![Plugin: Cowork](https://img.shields.io/badge/Claude%20Cowork-plugin-8A2BE2.svg)](https://code.claude.com/docs/en/plugin-marketplaces)

> *Stop using Claude like a chatbot. Start using it like infrastructure.*

</div>

---

Cowork AI OS is an open-source plugin that turns Claude Cowork into a configured AI teammate that knows your business, your voice, and your day. Built by [Nuno Tavares](https://nunomtavares.com) for VCI cohort students and anyone who wants to install AI infrastructure instead of bouncing between chat tabs.

---

## Quick links

| Section | Who it's for |
|---|---|
| [What you get](#what-you-get) | Everyone — what Cowork AI OS actually installs |
| [⚠️ Mac users — read this first](#-mac-users--read-this-first) | Mac users (git prereq + known Mac issues) |
| [⚠️ Windows users — read this first](#-windows-users--read-this-first) | Windows users (git prereq) |
| [Install](#install) | The 4-step install |
| [✅ Mac install (recommended): zip upload](#-mac-install-recommended-zip-upload) | **Recommended path for all Mac users** |
| [The 9 phases](#the-9-phases) | Time budget for onboarding |
| [Troubleshooting](#troubleshooting) | When things go sideways |

---

## What you get

- A `claude.md` handbook Claude reads on every session
- Four identity files describing who you are, what you sell, how you write, and what you've decided
- Gmail + Calendar wired with safe permissions
- A clean folder system Claude routes outputs to automatically
- Built-in skills enabled and a custom voice-tuned skill
- A daily brief firing every weekday morning
- Three recurring upkeep events so the system doesn't drift

All built through 9 guided phases. Pause-friendly. Sample-first. Resumable across sessions.

---

## ⚠️ Mac users — read this first

> **Use the [zip install](#-mac-install-recommended-zip-upload) — it's the recommended path on Mac.** Anthropic has open bugs affecting marketplace-based plugin installs in Cowork on macOS ([#26951](https://github.com/anthropics/claude-code/issues/26951), [#28125](https://github.com/anthropics/claude-code/issues/28125)). The zip upload bypasses all of them and is confirmed working in [#39400](https://github.com/anthropics/claude-code/issues/39400). The marketplace command in Step 3 below is documented as the secondary path — try it if you prefer, but if anything fails, jump to the zip path.

Before installing, open **Terminal** (Spotlight → "Terminal" → Enter) and run:

```bash
git --version
```

**If you see a version number** like `git version 2.43.0` → you're good. Skip to the install below.

**If you see "command not found"** → install git first:

```bash
xcode-select --install
```

Click **Install** in the popup. Wait ~5 minutes for the download. Then come back here.

> **Note:** macOS does not use "Git Bash" — that's Windows-only. You only need the underlying `git` tool, which `xcode-select --install` provides.

After installing git, **fully quit Claude Desktop** (⌘+Q — closing the window isn't enough) and relaunch before retrying the install.

---

## ⚠️ Windows users — read this first

Open **PowerShell** (Start menu → "PowerShell" → Enter) and run:

```powershell
git --version
```

**If you see a version number** → you're good. Skip to the install.

**If you see an error** → download Git for Windows from [git-scm.com/download/win](https://git-scm.com/download/win), run the installer, accept all defaults. This package includes both `git` and Git Bash.

After installing, fully quit Claude Desktop (right-click tray icon → Quit) and relaunch.

---

## Install

### Prerequisites

- [ ] Mac or Windows with admin install rights
- [ ] Paid Claude account (Pro $20/mo minimum — free tier doesn't include Cowork)
- [ ] Google account (for Gmail + Calendar in Phase 5)
- [ ] ~2 hours uninterrupted (or split across 2–3 sittings — pause-friendly)
- [ ] `git` installed (see above)

### Step 1 — Install Claude Desktop

Download from [claude.com/download](https://claude.com/download). Sign in to your paid account.

Confirm you see three tabs: **Chat**, **Co-Work**, **Code**. (No Co-Work tab? Update Claude Desktop.)

### Step 2 — Create your workspace folder

Create a folder named exactly `Claude Cowork` in your home directory.

> **Important:** NOT inside OneDrive, iCloud, Dropbox, or Google Drive. Cloud sync conflicts with Cowork.

In the Cowork tab, click **Choose folder**, select `Claude Cowork`, click **Allow**. Header should read **Working in: Claude Cowork**.

### Step 3 — Install Cowork AI OS

> **Mac user?** Skip to the [zip install](#-mac-install-recommended-zip-upload). It's the recommended path on Mac and works in ~30 seconds.

**Windows (and Mac users who prefer the marketplace):** in Claude Desktop, run:

```
/plugin marketplace add automatedmarketer/cowork-ai-os
/plugin install cowork-ai-os@cowork-ai-os
```

### Step 4 — Start onboarding

Open a fresh Cowork task. Type:

```
start onboarding
```

The 9-phase walkthrough begins.

---

## ✅ Mac install (recommended): zip upload

This is the recommended install path for all Mac users. It bypasses Anthropic's open Cowork-on-macOS bugs ([#26951](https://github.com/anthropics/claude-code/issues/26951), [#28125](https://github.com/anthropics/claude-code/issues/28125)) and works on every Cowork build that supports plugin uploads. Workaround confirmed by users in [#39400](https://github.com/anthropics/claude-code/issues/39400).

### 5 steps, ~30 seconds

1. Download the latest **`cowork-ai-os.zip`** from the [Releases page](https://github.com/automatedmarketer/cowork-ai-os/releases/latest) (or your training portal). **Don't extract it.** Keep the file as a single `.zip`.
2. Open Claude Desktop → click your name (top right) → **Settings**
3. Go to **Customize** → **Browse plugins** → look for the option to **upload a custom plugin file**
   > *Menu wording may vary slightly between Cowork versions — look for an "Upload", "Custom plugin", or "From file" option.*
4. Drag in the zip. Wait for confirmation.
5. Open a **fresh** Cowork task → type `start onboarding`

That's it. No marketplace, no terminal, no SSH keys, no `git --version` requirement.

> **Why is this the recommended Mac path?** Anthropic closed [#27196](https://github.com/anthropics/claude-code/issues/27196) ("All Anthropic plugins fail in Cowork on macOS") as **not planned** — they don't currently intend to fix the marketplace path on Mac. The zip-upload path is effectively the supported install method on macOS going forward.

### If something on stage looks weird

| Symptom | What to do |
|---|---|
| Can't find "Upload" / "Custom plugin" option | Look for "From file" / "Local plugin" / "Add manually". If genuinely absent, your Cowork version is older than the upload feature — quit, update Claude Desktop, relaunch. |
| Upload rejects the file | Confirm the file extension is `.zip` (not `.plugin`). Re-download directly from the Release page; don't rename. |
| Plugin uploads but `start onboarding` does nothing | Open a **brand new** Cowork task. Skills load on session start, not retroactively. |
| Plugin disappears after restart | That's [#38429](https://github.com/anthropics/claude-code/issues/38429) — Anthropic-side persistence bug. Re-upload the zip after restart. |

---

## What's inside

```
cowork-ai-os/                    ← the plugin
├── .claude-plugin/
│   └── plugin.json              Plugin metadata + version
├── skills/
│   ├── onboard/                 The 9-phase install walkthrough
│   │   ├── phases/              9 phase files (Phase 1 → Phase 9)
│   │   ├── samples/             Example files (sample-first onboarding)
│   │   └── templates/           Templates the install writes for you
│   ├── audit/                   "check my system" — score on the 4 C's
│   ├── level-up/                "what should I improve" — one specific move
│   ├── tune-up/                 "weekly tune-up" — 5-gate self-improvement
│   ├── morning-brief/           Daily inbox + calendar brief
│   ├── voice-writer/            Drafts in your voice
│   └── add-skill/               Hands off to Cowork's Skill Creator
├── CONNECTORS.md                Gmail + Calendar setup notes
├── LICENSE                      MIT
└── README.md                    Plugin-internal docs

.claude-plugin/marketplace.json  ← marketplace registration (repo root)
```

---

## The 9 phases

| Phase | What it builds | Time |
|-------|----------------|------|
| 1 | Handbook (`claude.md`) | ~10 min |
| 2 | About-me file | ~15 min |
| 3 | Business brain | ~15 min |
| 4 | Voice + memory files | ~20 min |
| 5 | Gmail + Calendar connectors | ~15 min |
| 6 | Folder system | ~5 min |
| 7 | Skills tour + plugin install | ~20 min |
| 8 | Daily brief on a schedule | ~15 min |
| 9 | Integrated verification + upkeep | ~15 min |

**Total:** ~2 hours. Pause anytime with `pause onboarding`. Resume with `continue onboarding`.

---

## Troubleshooting

### "Failed to install plugin" red toast (Mac)
Use the [zip install](#-mac-install-recommended-zip-upload) — it's the recommended Mac path anyway.

### `/plugin marketplace add` says "not found" or "could not connect"
- **On Mac:** that's [#28125](https://github.com/anthropics/claude-code/issues/28125) / [#26951](https://github.com/anthropics/claude-code/issues/26951). Use the [zip install](#-mac-install-recommended-zip-upload).
- **On Windows:** confirm git is installed (`git --version`), fully quit Claude Desktop (Quit from tray), and relaunch.

### Cowork doesn't recognize `/plugin` commands
Update Claude Desktop to the latest version. The plugin commands ship with Cowork — older builds don't have them.

### Plugin installs but skills don't load
Open a fresh Cowork task — skills load on session start. If still failing, see [#39274](https://github.com/anthropics/claude-code/issues/39274) (Anthropic-side issue).

### Install hangs at any phase
Type `pause onboarding`, close the task, open a fresh task, type `continue onboarding`. Cowork AI OS picks up where you left off — your `about-me/`, `outputs/`, and `_aibos/state.md` survive across sessions.

### How do I update Cowork AI OS?
```
/plugin update cowork-ai-os
```
Your `about-me/`, `outputs/`, and `_aibos/state.md` survive — they live in your workspace, not in the plugin.

---

## Curriculum (for VCI cohort students)

The full Project 01 — Core Setup curriculum (Quick Start + 8 lessons + concept deck) is available to VCI cohort members at [vcinc.com](https://vcinc.com). Each lesson maps 1:1 to a phase of this install.

---

## Built by

**[Nuno Tavares](https://nunomtavares.com)** — tech coach, founder of Automated Marketer, Lovable AI Ambassador, GoHighLevel Multiple Award Winner. Trains 7-figure entrepreneurs on AI infrastructure.

- 📰 Newsletter: [automatedmarketer.net](https://automatedmarketer.net)
- 📺 YouTube: [@AutomatedMarketer](https://youtube.com/@AutomatedMarketer)
- 🎓 VCI cohort: [vcinc.com](https://vcinc.com)

---

## Contributing

Issues and PRs welcome. If you hit a Mac install snag not covered in [Troubleshooting](#troubleshooting), please [open an issue](https://github.com/automatedmarketer/cowork-ai-os/issues/new) with:

- Your Cowork / Claude Desktop version
- The exact error message (red toast text or terminal output)
- Whether the [zip fallback](#-if-install-fails-on-mac) worked

That's the fastest way to get a fix landed.

---

## License

MIT — fork it, edit it, make it your own. See [LICENSE](LICENSE).

---

<div align="center">

*Cowork AI OS is open source at [github.com/automatedmarketer/cowork-ai-os](https://github.com/automatedmarketer/cowork-ai-os)*
*Built for VCI cohort students and anyone who wants to stop using Claude like a chatbot — and start using it like infrastructure.*

</div>
