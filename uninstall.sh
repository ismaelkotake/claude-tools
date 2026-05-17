#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_SRC="$REPO_DIR/commands"
DEFAULTS_SRC="$REPO_DIR/defaults"

COMMANDS_TARGET="${HOME}/.claude/commands"
DEFAULTS_TARGET="${HOME}/.claude/kotaketech/defaults"

echo "Removing kotaketech commands from $COMMANDS_TARGET..."
for file in "$COMMANDS_SRC"/*.md; do
  filename="$(basename "$file")"
  target="$COMMANDS_TARGET/$filename"
  if [ -f "$target" ]; then
    rm "$target"
    echo "  ✓ removed $filename"
  else
    echo "  - $filename not found, skipping"
  fi
done

echo ""
echo "Removing default rules/templates from $DEFAULTS_TARGET..."
for file in "$DEFAULTS_SRC"/*.md; do
  filename="$(basename "$file")"
  target="$DEFAULTS_TARGET/$filename"
  if [ -f "$target" ]; then
    rm "$target"
    echo "  ✓ removed $filename"
  else
    echo "  - $filename not found, skipping"
  fi
done

if [ -d "$DEFAULTS_TARGET" ] && [ -z "$(ls -A "$DEFAULTS_TARGET")" ]; then
  rmdir "$DEFAULTS_TARGET"
  rmdir "$(dirname "$DEFAULTS_TARGET")" 2>/dev/null || true
fi

echo ""
echo "Done."
