Push the current branch to the remote repository.

## Steps

1. Run `git status` to confirm there are no uncommitted changes. If there are, warn the user and suggest running `/kotaketech-commit` first.

2. Check the current branch name and whether it tracks a remote:
   ```
   git branch -vv
   ```

3. If the branch has no upstream, push with `-u`:
   ```
   git push -u origin <branch>
   ```
   Otherwise:
   ```
   git push
   ```

4. Report success or surface any errors (rejected push, no permission, etc.).

> Note: Never force-push (`--force`) without explicit user instruction. Never push directly to `main` or `master` without confirmation.