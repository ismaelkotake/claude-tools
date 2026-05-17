# kotaketech/claude-tools

Centralized slash commands for Claude Code, maintained by [Kotake Technology](https://kotaketech.com).

## Commands

| Command | Description |
|---|---|
| `/kotaketech-setup` | Initializes `.kotaketech/` in the current project with local copies of commit rules and PR template |
| `/kotaketech-commit` | Analyzes changes, groups logically, proposes conventional commits, updates CHANGELOG.md, and commits group by group |
| `/kotaketech-push` | Pushes the current branch to the remote repository |
| `/kotaketech-pr` | Creates a pull request with a generated title and description |

## Installation

```bash
git clone https://github.com/kotaketech/claude-tools.git
cd claude-tools
chmod +x install.sh
./install.sh
```

This copies all commands to `~/.claude/commands/` and the default rules/templates to `~/.claude/kotaketech/defaults/`.

## Per-project setup

Run once in each project to create local, customizable rules:

```
/kotaketech-setup
```

This creates `.kotaketech/` in the project root with:
- `commit-rules.md` — commit message conventions (types, scopes, changelog mapping)
- `pr-template.md` — PR title and description structure

Commit these files so the whole team shares the same conventions. Edit them to override the global defaults for that project.

## How rules resolution works

Commands look for project-local rules first, then fall back to global defaults:

```
.kotaketech/commit-rules.md        ← project-specific (if exists)
~/.claude/kotaketech/defaults/commit-rules.md  ← global default (fallback)
```

## Uninstallation

```bash
./uninstall.sh
```

## Updating

```bash
git pull
./install.sh
```

## Roadmap

- [ ] Evolve to an MCP Plugin (`@kotaketech/claude-tools`) for broader tool support (Cursor, VS Code Copilot, etc.)
