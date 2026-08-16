# Skill: Cargo and Tooling

Proficiency in Cargo workspaces, clippy, rustfmt, and rustdoc.

## Competencies

- Maintain workspace `[workspace.dependencies]`
- Keep `clippy -D warnings` clean
- Format with rustfmt, never by hand
- Write rustdoc examples that compile

## Commands

| Goal | Command |
|------|---------|
| Check | `cargo check --workspace` |
| Test | `cargo test --workspace` |
| Lint | `cargo clippy --workspace --all-targets -- -D warnings` |
| Format | `cargo fmt --all` |
| Docs | `cargo doc --workspace --no-deps` |

## Checklist

- New crates join the workspace
- New deps are justified
- CI runs fmt + clippy + test
