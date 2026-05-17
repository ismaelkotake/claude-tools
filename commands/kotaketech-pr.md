Create a pull request for the current branch with a generated title and description.

## Load template

Before starting, locate the PR template:
1. Check for `.kotaketech/pr-template.md` in the current project root. If found, use it.
2. Otherwise, use `~/.claude/kotaketech/defaults/pr-template.md`.

Use that template's structure and rules when generating the PR description.

## Steps

### 1. Pre-flight checks

- Run `git status` to confirm there are no uncommitted changes. If there are, warn the user and suggest running `/kotaketech-commit` first.
- Check if the branch is pushed to the remote (`git branch -vv`). If not, offer to push it before continuing.

### 2. Analyze commits

Determine the base branch (default: `main`). Run:
```bash
git log <base>...HEAD --oneline
git diff <base>...HEAD
```

Read all commits and the full diff to understand the scope of changes.

### 3. Generate PR content

Using the loaded template structure, generate:
- A PR **title** following the template's title format rules
- A **description** filled with accurate, factual content based on the actual changes

Do not use filler phrases. Every bullet should state something specific and true about the diff.

### 4. Confirm with user

Show the generated title and description and ask:
```
Title      : feat(auth): add JWT token refresh endpoint
Description: [rendered content]

Proceed? [yes / edit title / edit description / abort]
```

Allow the user to edit the title or description before creating the PR.

### 5. Create PR

```bash
gh pr create --title "<title>" --body "<description>"
```

Return the PR URL when done.

> Never close, merge, or request review on PRs automatically.
