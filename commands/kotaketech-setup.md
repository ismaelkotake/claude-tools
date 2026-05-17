Initialize kotaketech configuration for the current project.

Creates a `.kotaketech/` directory with local copies of the commit rules and PR template, which can be customized per project. Commands like `/kotaketech-commit` and `/kotaketech-pr` will use these project-local files instead of the global defaults.

## Steps

1. Check if `.kotaketech/` already exists in the current working directory.
   - If it exists, list its contents and ask the user whether to overwrite, skip existing files, or abort.

2. Locate the global defaults at `~/.claude/kotaketech/defaults/`. If the directory doesn't exist, inform the user that the defaults are missing and suggest re-running `install.sh` from the claude-tools repository.

3. Create `.kotaketech/` if it doesn't exist.

4. Copy the following files from `~/.claude/kotaketech/defaults/` to `.kotaketech/`:
   - `commit-rules.md`
   - `pr-template.md`

5. Add `.kotaketech/` to version control awareness:
   - Check if a `.gitignore` exists. If so, verify `.kotaketech/` is **not** in it (these files should be committed — they are project conventions).
   - If a `CHANGELOG.md` does **not** exist in the project root, ask the user if they want one created. If yes, create it with this initial content:
     ```markdown
     # Changelog

     All notable changes to this project will be documented in this file.

     The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

     ## [Unreleased]
     ```

6. Confirm what was created and remind the user they can edit `.kotaketech/commit-rules.md` and `.kotaketech/pr-template.md` to customize conventions for this project.
