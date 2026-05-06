#!/usr/bin/env bash
# build-release-zip.sh
#
# Build the cowork-aibos.zip artifact used by Mac users to install/update
# via Settings → Customize → Browse plugins.
#
# Usage:
#   chmod +x build-release-zip.sh
#   ./build-release-zip.sh
#
# Output:
#   release/cowork-aibos.zip
#
# Then attach the zip to the GitHub release.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$REPO_ROOT/cowork-aibos"
RELEASE_DIR="$REPO_ROOT/release"
ZIP_NAME="cowork-aibos.zip"
ZIP_PATH="$RELEASE_DIR/$ZIP_NAME"

# Sanity checks
if [[ ! -d "$PLUGIN_DIR" ]]; then
  echo "ERROR: Plugin folder not found at $PLUGIN_DIR"
  exit 1
fi

if [[ ! -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]]; then
  echo "ERROR: plugin.json not found in $PLUGIN_DIR/.claude-plugin/"
  exit 1
fi

# Read version from plugin.json (no jq dependency — grep + sed)
VERSION=$(grep -E '"version"' "$PLUGIN_DIR/.claude-plugin/plugin.json" | head -1 | sed -E 's/.*"version"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')

if [[ -z "$VERSION" ]]; then
  echo "ERROR: Could not parse version from plugin.json"
  exit 1
fi

echo "→ Building cowork-aibos v$VERSION zip"

# Clean and create release dir
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"

# Build the zip
# IMPORTANT: zip from INSIDE the plugin dir so the archive has plugin contents at the
# zip root (`.claude-plugin/plugin.json` at root, no nested `cowork-aibos/` folder).
# Cowork's "Customize → Browse plugins → upload" flow expects this flat layout —
# v0.5.2 shipped this way and worked. Nesting under `cowork-aibos/` breaks Mac install.
cd "$PLUGIN_DIR"

# Exclude:
#   - macOS metadata (.DS_Store, ._* AppleDouble files)
#   - Editor swap files
#   - Build artifacts
zip -r "$ZIP_PATH" . \
  -x "*.DS_Store" \
  -x "**/.DS_Store" \
  -x "**/._*" \
  -x "*.swp" \
  -x "**/.git/*" \
  -x "**/node_modules/*" \
  >/dev/null

# Verify the zip
echo ""
echo "→ Verifying zip contents..."

REQUIRED_FILES=(
  "cowork-aibos/.claude-plugin/plugin.json"
  "cowork-aibos/skills/onboard/SKILL.md"
  "cowork-aibos/skills/morning-brief/SKILL.md"
  "cowork-aibos/skills/onboard-daily-brief/SKILL.md"
  "cowork-aibos/skills/brief-source-comms/SKILL.md"
)

MISSING=0
ZIP_LISTING=$(unzip -l "$ZIP_PATH" 2>/dev/null)
for f in "${REQUIRED_FILES[@]}"; do
  if echo "$ZIP_LISTING" | grep -q "$f"; then
    echo "  ✓ $f"
  else
    echo "  ✗ MISSING: $f"
    MISSING=$((MISSING + 1))
  fi
done

if [[ $MISSING -gt 0 ]]; then
  echo ""
  echo "ERROR: $MISSING required file(s) missing from zip. Aborting."
  rm -f "$ZIP_PATH"
  exit 1
fi

# Final summary
ZIP_SIZE=$(du -h "$ZIP_PATH" | cut -f1)
FILE_COUNT=$(unzip -l "$ZIP_PATH" 2>/dev/null | tail -1 | awk '{print $2}')

echo ""
echo "✓ Built: $ZIP_PATH"
echo "  Version: v$VERSION"
echo "  Size: $ZIP_SIZE"
echo "  Files: $FILE_COUNT"
echo ""
echo "Next steps:"
echo "  1. Attach $ZIP_NAME to the GitHub release for v$VERSION"
echo "  2. Reference RELEASE-v$VERSION.md as the release notes"
echo "  3. Mac users download → Settings → Customize → Browse plugins → upload"
