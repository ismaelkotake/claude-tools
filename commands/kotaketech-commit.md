Analyze staged and unstaged changes, group them into logical commits, and commit group by group after user confirmation. Updates CHANGELOG.md if it exists.

## Load rules

Before starting, locate the commit rules:
1. Check for `.kotaketech/commit-rules.md` in the current project root. If found, use it.
2. Otherwise, use `~/.claude/kotaketech/defaults/commit-rules.md`.

Read and apply the rules from that file throughout this command.

## Steps

### 1. Analyze changes

Run `git status` and `git diff HEAD` (both staged and unstaged) to understand all pending changes.

### 2. Group changes

Divide files into logical groups where each group will become one commit. Grouping criteria:
- Files that implement the same feature or fix go together
- Test files go in the same commit as the code they test
- Config/dependency changes go with the feature that needs them
- Never mix unrelated concerns in a single group

### 3. Propose commits

For each group, display:

```
Commit N/Total
  Message : feat(auth): add JWT token refresh endpoint
  Files   : src/auth/refresh.ts, src/auth/refresh.test.ts
  Proceed? [yes / edit / skip]
```

- **yes** — commit this group as proposed
- **edit** — ask for the new message, then confirm again
- **skip** — move to the next group without committing

### 4. Commit rules

- Follow the rules loaded in step "Load rules"
- **All commit messages must be written in English** — subject, body, and footer
- **Never use `git add .` or `git add -A`** — always stage files by name
- Never skip hooks (`--no-verify`)
- Never amend published commits
- Stage and commit each group sequentially after user confirms

For each confirmed group:
```bash
git add <specific files>
git commit -m "<message>"
```

### 5. Update CHANGELOG.md

After each successful commit, check if `CHANGELOG.md` exists in the project root.

If it exists:
- Find the `## [Unreleased]` section (create it at the top if missing, after the title block)
- Map the commit type to a changelog category using the rules from the commit-rules file
- Add an entry under the appropriate subsection (`### Added`, `### Fixed`, `### Changed`, etc.)
- Entry format: `- <subject line from the commit message> (<short hash>)`
- **All CHANGELOG entries must be written in English**
- If the commit type maps to "Omit", skip the changelog update for that commit
- Stage `CHANGELOG.md` and amend it into the current commit:
  ```bash
  git add CHANGELOG.md
  git commit --amend --no-edit
  ```

### 6. Summary

After all groups are processed, show:
- How many commits were created
- Which groups were skipped
- Whether CHANGELOG.md was updated
