# Skill: Code Review

Proficiency in reviewing Rust for idioms and architecture.

## Competencies

- Detect clone-to-compile and hidden panics
- Check public API ownership (`&str` vs `String`)
- Verify tests cover error paths
- Flag unexplained `unsafe`

## Context

Reviews keep Cursor IBKR TWS Lab lessons honest and crates teachable.

## Review Checklist

- rustfmt + clippy clean
- Ownership model is sound
- `Result` used for failure
- Tests included
- rustdoc on new public items
