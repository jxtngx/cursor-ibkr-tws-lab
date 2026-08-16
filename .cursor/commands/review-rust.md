# Review Rust

Review the current diff for idiomatic Rust.

## Usage

```
@review-rust
```

## Checks

| Check | Command / rule |
|-------|----------------|
| Format | `cargo fmt --all -- --check` |
| Lint | `cargo clippy --workspace --all-targets -- -D warnings` |
| Tests | `cargo test --workspace` |
| Ownership | No clone-to-compile |
| Errors | No `unwrap` in library paths |
| Unsafe | SAFETY comment required |
| Docs | rustdoc on new public items |

## Output

```
## Review
- PASS / FAIL per check
- Findings (file:item)
- Required fixes
- Optional nits
```

## Constraints

- Do not implement fixes unless the user asks
- Do not expand scope beyond the diff
