# Definition of Done

Checklist that every story must satisfy before being marked complete.

## Code Complete

- [ ] Implementation matches acceptance criteria
- [ ] Code follows rustfmt and project style
- [ ] `cargo clippy --all-targets -- -D warnings` is clean
- [ ] No commented-out code or TODOs
- [ ] Public items have rustdoc

## Testing

- [ ] Unit tests written and passing (`cargo test`)
- [ ] Integration tests written (if applicable)
- [ ] Lesson exercises have failing-then-passing tests
- [ ] Manual `cargo run` / example check completed

## Code Review

- [ ] Pull request created
- [ ] Chief Architect or peer review approved
- [ ] All review comments addressed
- [ ] CI pipeline passes

## Documentation

- [ ] rustdoc on public functions, types, and modules
- [ ] README updated (if user-facing change)
- [ ] Lesson notes updated (if a learning change)
- [ ] Architecture docs updated (if design change)

## Integration

- [ ] Merged to main branch
- [ ] No merge conflicts
- [ ] No breaking changes (or migration path provided)

## Story-Specific

Additional criteria based on story type:

| Type | Additional Requirements |
|------|-------------------------|
| Lesson | Concept explained, exercise compiles, tests pass |
| New Feature | User acceptance demo, rustdoc examples |
| Bug Fix | Regression test, root cause documented |
| Refactoring | `cargo test` and benches unchanged or improved |
| API Change | Backward compatibility or deprecation notice |

## Verification

Before marking done, ask:
1. Would this pass a code review?
2. Can a learner understand this?
3. Is this idiomatic Rust?
4. Does this add technical debt?
