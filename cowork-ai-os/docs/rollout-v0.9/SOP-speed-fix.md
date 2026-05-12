# SOP — Cowork AI OS Speed Fix (v0.9 Upgrade)

**Audience:** Students who installed Cowork AI OS v0.7 or v0.8 and want to upgrade to v0.9.
**Time:** 2 minutes.
**Where this lives:** Google Drive → Course SOPs folder, alongside Project 01 install SOP.

---

## What this fix does

Cowork was telling Claude to re-read your entire identity folder on every prompt. That's why "Start Up" took 20+ seconds. v0.9 removes that instruction so Claude only loads identity when a skill actually needs it. Your "Start Up" drops to under 3 seconds.

Your identity files (about-me, writing-rules, memory, business-brain, connections) are **preserved**. Your scheduled tasks (morning brief, weekly tune-up) **keep running**. Nothing in your workspace is lost.

---

## Before you start

You'll need:
- Cowork open in a browser tab or the desktop app.
- ~2 minutes of uninterrupted time (the paste step is the only manual part).

You won't need:
- GitHub access.
- Command line / terminal.
- Any technical knowledge beyond copy-paste.

---

## The 5 steps

### Step 1 — Update the plugin

In Cowork, in any task or a brand-new one, type:

```
/plugin update cowork-ai-os
```

Wait for Cowork to confirm the update is done (usually 5–10 seconds).

**Mac users:** Cowork's `/plugin update` is unreliable on Mac. If the command doesn't work or stalls, use the zip-upload fallback instead:
1. Download `cowork-ai-os.zip` from [github.com/AutomatedMarketer/cowork-ai-os/releases/latest](https://github.com/AutomatedMarketer/cowork-ai-os/releases/latest)
2. In Cowork: Settings → Customize → Browse plugins → Install from file → select the .zip
3. Your workspace files survive the re-upload.

### Step 2 — Run `/optimize`

In the same Cowork task, type:

```
/optimize
```

The skill will:
- Read your current handbook and memory file.
- Tell you what it found ("old handbook directive detected" / "memory has N entries").
- Ask if you want it to fix things.

Type **yes** to proceed.

### Step 3 — Confirm the backup

The skill will tell you it's backed up your current `claude.md` and `memory.md` to a folder called `_aibos/backups/`. This is so you can `rollback` if anything looks wrong.

You don't need to do anything here — just read the confirmation.

### Step 4 — Paste the new handbook into Cowork Settings

This is the only manual step. The skill will show you a new handbook in a copy-friendly code block. Your existing answers (name, tone, priorities, etc.) are already filled in for you.

1. **Copy** the entire code block.
2. Open **Cowork → Settings → Cowork → Global instructions**.
3. Click Edit. **Select all the existing text** in the Global instructions field. **Replace it** with what you just copied.
4. Click Save.
5. Back in your Cowork task, type **done**.

The skill will then archive any memory overflow silently (you won't see this — it just happens) and write a log entry.

### Step 5 — Test it

Send any short prompt in Cowork. Examples:
- "What time is it?"
- "Summarize how I want you to work with me."
- "Test."

"Start Up" should be under 3 seconds. The response should still know who you are — that's because skills load identity on demand, not because it's in your Global Instructions anymore.

---

## If something looks wrong

Type **rollback** within the same Cowork task. This will:
- Restore your old `claude.md` from the backup.
- Restore your old `memory.md` from the backup.
- Tell you to paste the old handbook back into Cowork → Settings → Global instructions (it'll show you the content again).

Your `about-me/` files are never touched, so they're never at risk.

---

## How to know it worked

Three signs:

1. **Speed.** Prompts respond in under 3 seconds instead of 20+.
2. **Personality preserved.** Ask "Summarize how I want you to work with me." It should still answer in your voice, with your tone preferences and priorities.
3. **Scheduled tasks keep firing.** If you have `/morning-brief` scheduled, tomorrow's brief should arrive as usual.

---

## If you ever feel slow again later

Just run `/optimize` again. It's not a one-time fix — it's a permanent tool. If your `memory.md` grows past 30 entries (about 6 months of daily use), it'll archive the overflow automatically inside any skill that appends memory. But you can also run `/optimize` manually any time to clean up.

---

## Questions?

Email Nuno: nuno@digitalvoltage.net.

If you lost meaningful working time to the slowness before today, mention it in your email and Nuno will refund the hour.
