# PR Template

## Title format

```
<type>(<scope>): <short summary>
```

- Max 70 characters
- Same type/scope conventions as commit messages
- Imperative mood, no period

## Description structure

```markdown
## Summary

- <bullet: what changed and why>
- <bullet: ...>

## Changes

- <bullet: notable implementation detail or decision>

## Test plan

- [ ] <how to verify this works>
- [ ] <edge case to check>

## Breaking changes

> Remove this section if there are none.

- <describe what breaks and migration path>
```

## Rules

- The PR title must match the squash-merge commit message format
- Link related issues in the footer: `Closes #123`
- Keep the description factual — no filler phrases ("this PR adds...", "as mentioned...")
- If the PR is a draft, prefix the title with `[WIP]`
