# Skill: Cargo Testing

Proficiency in `cargo test` unit and integration tests.

## Competencies

- Write `#[cfg(test)]` modules next to code
- Write `tests/*.rs` integration tests
- Use table-driven tests
- Isolate filesystem and env side effects

## Context

Lessons and crates are done only when `cargo test` is green.

## Checklist

- Test names describe behavior
- Error paths are covered
- `cargo test --workspace` is the source of truth
- No adhoc `check_*.rs` scripts
