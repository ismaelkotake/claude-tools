Create a pull request for the current branch with a generated title and description.

## Load template

Before starting, locate the PR template:
1. Check for `.kotaketech/pr-template.md` in the current project root. If found, use it.
2. Otherwise, use `~/.claude/kotaketech/defaults/pr-template.md`.

Use that template's structure and rules when generating the PR description.

## Steps

### 1. Detect remote platform

Run `git remote get-url origin` and determine the platform:
- URL contains `github.com` → **GitHub** (use `gh` CLI)
- URL contains `gitlab.com` or a self-hosted GitLab domain → **GitLab** (use `glab` CLI)
- Ambiguous or no remote → ask the user before continuing

Remember this choice for step 7.

### 2. Pre-flight checks

- Run `git status` to confirm there are no uncommitted changes. If there are, warn the user and suggest running `/kotaketech-commit` first.
- Check if the branch is pushed to the remote (`git branch -vv`). If not, offer to push it before continuing.

### 3. Choose target branch

List the branches available on the remote:
```bash
git branch -r | sed 's|origin/||' | sort
```

Ask the user which branch the PR/MR should target. Show the list and prompt:
```
Target branch? (e.g. main, develop, release/1.2.0)
```

Use the chosen branch as `<base>` in the next steps.

### 4. Analyze commits

Run:
```bash
git log <base>...HEAD --oneline
git diff <base>...HEAD
```

Read all commits and the full diff to understand the scope of changes.

### 5. Generate PR content

Using the loaded template structure, generate:
- A PR **title** following the template's title format rules
- A **description** filled with accurate, factual content based on the actual changes
- **Title and description must be written in English**

Do not use filler phrases. Every bullet should state something specific and true about the diff.

### 6. Confirm with user

Show the generated title and description and ask:
```
Target     : <base>
Title      : feat(auth): add JWT token refresh endpoint
Description: [rendered content]

Proceed? [yes / edit title / edit description / abort]
```

Allow the user to edit the title or description before creating the PR.

### 7. Create PR

Use the CLI determined in step 1:

**GitHub:**
```bash
gh pr create --base <base> --title "<title>" --body "<description>"
```

**GitLab:**
```bash
glab mr create --target-branch <base> --title "<title>" --description "<description>"
```

Return the PR/MR URL when done.

> Never close, merge, or request review on PRs/MRs automatically.