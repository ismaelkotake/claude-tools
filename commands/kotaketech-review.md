Analyze a pull request (or the current branch diff) as a senior software engineer and produce a structured review. Uses Claude Opus 4.8 as the reviewing model.

Accepts an optional argument: a PR/MR number or URL. If omitted, analyzes the diff between the current branch and its base.

## Steps

### 1. Detect remote platform

Run `git remote get-url origin` and determine the platform:
- URL contains `github.com` → **GitHub** (use `gh` CLI)
- URL contains `gitlab.com` or a self-hosted GitLab domain → **GitLab** (use `glab` CLI)
- Ambiguous or no remote → ask the user before continuing

### 2. Gather PR data

**If a PR/MR number or URL was given:**

GitHub:
```bash
gh pr view <number> --json number,title,body,baseRefName,headRefName,author,additions,deletions,changedFiles,labels,reviewDecision
gh pr diff <number>
```

GitLab:
```bash
glab mr view <number>
glab mr diff <number>
```

**If no argument was given (current branch):**

```bash
git log origin/main...HEAD --oneline
git diff origin/main...HEAD
```

Also collect:
```bash
git log origin/main...HEAD --format="%H %s"
```

Store:
- `PR_TITLE` — title of the PR/MR (or branch name if local)
- `PR_DESCRIPTION` — body/description
- `BASE_BRANCH` — target branch
- `DIFF` — full unified diff
- `COMMIT_LOG` — one-line log of commits

### 3. Run senior-engineer review via Opus 4.8

Spawn an Agent with **`model: opus`** and the following prompt (fill in the placeholders with real data gathered in step 2):

---

**Agent prompt template:**

```
You are a senior software engineer conducting a thorough pull request review.
Your job is to be precise, honest, and actionable — like a careful human reviewer who cares about production stability.

## PR metadata

Title      : {{PR_TITLE}}
Target     : {{BASE_BRANCH}}
Description:
{{PR_DESCRIPTION}}

## Commits

{{COMMIT_LOG}}

## Diff

{{DIFF}}

---

Produce a structured review with the following sections. Use Markdown. Be specific — cite file names and line numbers where relevant.

### Summary
Two to four sentences describing what this PR does and whether the approach is sound.

### Critical Issues 🔴
Bugs, security vulnerabilities, data-loss risks, or broken contracts that must be fixed before merge.
If none, write "None found."

### Warnings ⚠️
Performance concerns, architectural mismatches, missing error handling, or design decisions that should be discussed.
If none, write "None found."

### Suggestions 💡
Code quality, readability, naming, test coverage gaps, dead code, or minor improvements. These are optional but valuable.
If none, write "None found."

### Test Coverage
Assess whether the changes are adequately tested. Note any untested paths or edge cases.

### Commit Quality
Evaluate whether commit messages are clear, atomic, and follow conventional commits. Flag any squash candidates.

### Verdict
One of:
- ✅ **Approve** — ready to merge as-is
- 🔁 **Request Changes** — must address Critical Issues or Warnings before merge
- 💬 **Needs Discussion** — design or scope concerns require alignment before proceeding

Be direct. Do not soften findings with filler phrases.
```

---

Return the agent's full Markdown output as the review.

### 4. Display review

Print the review produced by the Opus agent in full.

Then ask the user:

```
Post this review as a comment on the PR? [yes / no]
```

### 5. (Optional) Post review comment

If the user answers **yes**:

GitHub:
```bash
gh pr review <number> --comment --body "<review content>"
```

GitLab:
```bash
glab mr note <number> --message "<review content>"
```

If the review was run against the local branch (no PR number), inform the user that posting requires a PR/MR to exist first and offer to run `/kotaketech-pr` to create one.

> Never approve or merge PRs automatically. Never request changes via the platform API — only post the review as a comment.
