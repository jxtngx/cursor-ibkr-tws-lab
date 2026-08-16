# Skill: Rust Modules

Proficiency in crate layout, visibility, and re-exports.

## Competencies

- Split a crate into modules without losing discoverability
- Use `pub(crate)` vs `pub`
- Re-export a small public surface from `lib.rs`
- Name modules after concepts, not types alone

## Context

Lesson crates stay small. Shared code belongs in `crates/` with a tight public API.

## Checklist

- `lib.rs` is a map, not a dump
- Internal modules are private by default
- Public API is documented
- No circular module dependencies
