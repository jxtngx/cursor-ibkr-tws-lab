# Conventional Commits

All commits MUST follow the Conventional Commits specification.

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

| Type | Purpose | Changelog Section |
|------|---------|-------------------|
| `feat` | New feature or lesson | Features |
| `fix` | Bug fix | Bug Fixes |
| `perf` | Performance improvement | Performance |
| `refactor` | Code restructuring | Refactoring |
| `docs` | Documentation or lesson notes | Documentation |
| `test` | Test additions/changes | Testing |
| `build` | Cargo / workspace changes | Build System |
| `ci` | CI configuration | CI/CD |
| `chore` | Maintenance tasks | Chores |
| `revert` | Revert previous commit | Reverts |
| `style` | rustfmt-only changes | (omitted) |

## Scope

| Scope | Area |
|-------|------|
| `lesson` | `lessons/*` |
| `crate` | `crates/*` or root crate |
| `ownership` | ownership / borrow lessons |
| `traits` | trait lessons and APIs |
| `error` | `Result` / error types |
| `tests` | `tests/` or `#[cfg(test)]` |
| `cargo` | `Cargo.toml`, features, workspace |
| `docs` | README, rustdoc, `.cursor/` |

## Description Guidelines

The description MUST:

- Be imperative mood: "add" not "added" or "adds"
- Be lowercase (except proper nouns)
- NOT end with a period
- Be clear and specific

Good:

```
feat(lesson): add ownership move-vs-borrow exercise
fix(error): propagate io::Error with From
docs: explain lifetime elision in rust-lifetimes skill
```

Bad:

```
feat(lesson): Added ownership lesson.
fix(error): fixes bug
docs: Updates.
```

## Footers

| Footer | Usage |
|--------|-------|
| `Fixes #123` | Links to GitHub issue |
| `Closes #123` | Closes GitHub issue |
| `BREAKING CHANGE:` | Describes breaking change |
| `Refs #123` | References issue without closing |

## Enforcement

All commits MUST follow this format. Do not add tool attribution trailers.
