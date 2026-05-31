Push the current branch to the remote repository.

## Steps

1. Run `git status` to confirm there are no uncommitted changes. If there are, warn the user and suggest running `/kotaketech-commit` first.

2. Detect the remote platform by running `git remote get-url origin`:
   - URL contains `github.com` → **GitHub**
   - URL contains `gitlab.com` or a self-hosted GitLab domain → **GitLab**
   - Ambiguous or no remote → ask the user before continuing

3. Check the current branch name and whether it tracks a remote:
   ```
   git branch -vv
   ```

4. Update or create `CHANGELOG.md` using the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format:

   - Run `git log` to identify commits not yet reflected in the changelog. If the file doesn't exist, use all commits on the current branch since it diverged from the main branch (or all commits if on main).
   - If `CHANGELOG.md` does not exist, create it with the standard header:
     ```markdown
     # Changelog

     All notable changes to this project will be documented in this file.

     The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
     and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

     ## [Unreleased]
     ```
   - Add or update the `## [Unreleased]` section at the top with entries grouped by type (`Added`, `Changed`, `Fixed`, `Removed`, `Security`, `Deprecated`) based on the commit messages.
   - **All CHANGELOG entries must be written in English.**
   - Stage and commit the changelog:
     ```
     git add CHANGELOG.md
     git commit -m "docs: update CHANGELOG"
     ```

5. If the branch has no upstream, push with `-u`:
   ```
   git push -u origin <branch>
   ```
   Otherwise:
   ```
   git push
   ```

6. Report success or surface any errors (rejected push, no permission, etc.).

> Note: Never force-push (`--force`) without explicit user instruction. Never push directly to `main` or `master` without confirmation.