# Commit Rules

## Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

## Types

| Type | When to use |
|---|---|
| `feat` | A new feature visible to users or consumers of the API |
| `fix` | A bug fix |
| `refactor` | Code change that neither adds a feature nor fixes a bug |
| `perf` | Performance improvement |
| `test` | Adding or correcting tests |
| `docs` | Documentation only changes |
| `chore` | Build process, dependency updates, tooling, CI/CD |
| `ci` | Changes to CI/CD pipeline configuration |
| `style` | Formatting only (no logic change) |
| `revert` | Reverts a previous commit |

## Scope

- Optional. Use the main module, feature area, or layer being changed.
- Examples: `feat(auth):`, `fix(payment):`, `chore(deps):`
- Use lowercase, short, and consistent across the project.

## Subject line

- Imperative mood: "add endpoint" not "added endpoint" or "adds endpoint"
- Max 72 characters
- No period at the end
- Lowercase after the colon

## Body (optional)

- Explain **why**, not what (the diff already shows what)
- Separate from subject with a blank line
- Wrap at 72 characters

## Footer (optional)

- `BREAKING CHANGE: <description>` — triggers a major version bump
- `Refs: #123` — reference issues or tickets
- Use `!` after type/scope for breaking changes: `feat(api)!: remove v1 endpoints`

## Changelog mapping

When updating CHANGELOG.md, map commit types to sections:

| Commit type | Changelog section |
|---|---|
| `feat` | Added |
| `fix` | Fixed |
| `refactor`, `perf` | Changed |
| `revert` | Changed |
| `chore` (security-related) | Security |
| `docs`, `test`, `chore`, `ci`, `style` | Omit (not user-facing) |

Breaking changes always appear in a **Breaking Changes** subsection regardless of type.
