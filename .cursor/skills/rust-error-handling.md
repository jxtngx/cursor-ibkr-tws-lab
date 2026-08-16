# Skill: Rust Error Handling

Proficiency in `Option`, `Result`, and crate-local error types.

## Competencies

- Use `Option` for absence, `Result` for failure
- Propagate with `?`
- Map and wrap errors without losing context
- Reserve `unwrap` / `expect` for proven invariants or tests

## Context

Library code in this repo must not panic on expected failures.

## Checklist

- Public functions return `Result` when they can fail
- Error type implements `std::error::Error` + `Display`
- `From` impls exist for wrapped errors
- No hidden `unwrap` in library paths
