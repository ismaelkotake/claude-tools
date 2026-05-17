#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_SRC="$REPO_DIR/commands"
DEFAULTS_SRC="$REPO_DIR/defaults"

COMMANDS_TARGET="${HOME}/.claude/commands"
DEFAULTS_TARGET="${HOME}/.claude/kotaketech/defaults"

mkdir -p "$COMMANDS_TARGET"
mkdir -p "$DEFAULTS_TARGET"

echo "Installing kotaketech commands to $COMMANDS_TARGET..."
for file in "$COMMANDS_SRC"/*.md; do
  filename="$(basename "$file")"
  cp "$file" "$COMMANDS_TARGET/$filename"
  echo "  ✓ $filename"
done

echo ""
echo "Installing default rules/templates to $DEFAULTS_TARGET..."
for file in "$DEFAULTS_SRC"/*.md; do
  filename="$(basename "$file")"
  cp "$file" "$DEFAULTS_TARGET/$filename"
  echo "  ✓ $filename"
done

echo ""
echo "Done. Commands available in Claude Code:"
echo "  /kotaketech-setup    — initialize a project with local rules/templates"
echo "  /kotaketech-commit   — smart grouped commits with CHANGELOG support"
echo "  /kotaketech-push     — push current branch"
echo "  /kotaketech-pr       — create PR with generated description"
