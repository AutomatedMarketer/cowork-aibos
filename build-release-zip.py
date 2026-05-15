#!/usr/bin/env python3
"""Build release zip for cowork-ai-os plugin (Windows fallback for bash script).

Reads VERSION from cowork-ai-os/.claude-plugin/plugin.json.
Produces FLAT zip layout (.claude-plugin/plugin.json at zip root, no nested
wrapper directory) — required for Mac install via Cowork's
Customize ==> Browse plugins ==> upload flow.

Defensive excludes:
- .DS_Store / ._* AppleDouble (macOS metadata)
- .swp (editor swap files)
- .git/ / build artifacts
- node_modules/
- docs/sops/* (course IP rule — never ship SOPs in public plugin repo)
"""

from __future__ import annotations

import json
import os
import sys
import zipfile
from pathlib import Path

PLUGIN_DIR = Path("cowork-ai-os")
RELEASE_DIR = Path("release")
ZIP_NAME = "cowork-ai-os.zip"

EXCLUDE_PATTERNS = (
    ".DS_Store",
    "._",
    ".swp",
)

EXCLUDE_DIR_PREFIXES = (
    ".git",
    "node_modules",
    "docs/sops",
    "docs\\sops",
)

REQUIRED_FILES = [
    ".claude-plugin/plugin.json",
    "skills/onboard/SKILL.md",
    "skills/morning-brief/SKILL.md",
    "skills/onboard-daily-brief/SKILL.md",
    "skills/brief-source-comms/SKILL.md",
]


def should_exclude(rel_path: str) -> bool:
    for pat in EXCLUDE_PATTERNS:
        if pat in rel_path:
            return True
    for prefix in EXCLUDE_DIR_PREFIXES:
        if rel_path.startswith(prefix) or f"/{prefix}" in rel_path:
            return True
    return False


def main() -> int:
    plugin_manifest = PLUGIN_DIR / ".claude-plugin" / "plugin.json"
    if not plugin_manifest.exists():
        print(f"ERROR: {plugin_manifest} not found", file=sys.stderr)
        return 1

    with plugin_manifest.open(encoding="utf-8") as fh:
        manifest = json.load(fh)
    version = manifest.get("version")
    if not version:
        print("ERROR: could not parse version from plugin.json", file=sys.stderr)
        return 1

    print(f"==> Building cowork-ai-os v{version} zip (flat layout for Mac install)")

    RELEASE_DIR.mkdir(exist_ok=True)
    zip_path = RELEASE_DIR / ZIP_NAME
    if zip_path.exists():
        zip_path.unlink()

    file_count = 0
    written_paths = set()
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for root, dirs, files in os.walk(PLUGIN_DIR):
            dirs[:] = [
                d for d in dirs
                if not should_exclude(
                    str(Path(root) / d).replace(str(PLUGIN_DIR) + os.sep, "").replace("\\", "/")
                )
            ]
            for fname in files:
                src = Path(root) / fname
                rel = src.relative_to(PLUGIN_DIR).as_posix()
                if should_exclude(rel):
                    continue
                zf.write(src, arcname=rel)
                written_paths.add(rel)
                file_count += 1

    # Verify required files (FLAT paths — same as the working v0.5.2 layout)
    missing = [f for f in REQUIRED_FILES if f not in written_paths]
    if missing:
        print(f"\nERROR: {len(missing)} required file(s) missing from zip:", file=sys.stderr)
        for m in missing:
            print(f"  [MISSING] {m}", file=sys.stderr)
        zip_path.unlink()
        return 1

    print(f"\n==> Verifying zip contents (flat layout — .claude-plugin/plugin.json at root):")
    for f in REQUIRED_FILES:
        print(f"  [OK] {f}")

    size = zip_path.stat().st_size
    print(f"\nBuilt: {zip_path}")
    print(f"Size: {size} bytes")
    print(f"Files: {file_count}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
