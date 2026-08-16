# Lesson 09 — Tests and rustdoc: the PR bar

> Official spine: [Book ch. 11](https://doc.rust-lang.org/book/ch11-00-testing.html) · [rustdoc book](https://doc.rust-lang.org/rustdoc/) · [Cargo Book — tests](https://doc.rust-lang.org/cargo/guide/tests.html)
> Companion: Rustlings tests; clippy; rustfmt
> Contribution target: Candle and opencv-rust both expect tests + rustdoc. This lesson is the bar for lesson 12's PR.
> Domain hook: table-driven IoU, association, and state-machine tests are what make a tracker mergeable.

## Contract

The tutor reviews coverage gaps.
The tutor does not write the tables.
No adhoc `check_*.rs` scripts (see `.cursor/rules/proper-tests.mdc`).

## Read first (do not skip)

- [ ] Book ch. 11 — unit tests, integration tests, `#[should_panic]`, `Result` in tests
- [ ] rustdoc book: what makes a doc-test
- [ ] One Candle PR or test module (e.g. a small `candle-core` op test) — how they name tests
- [ ] opencv-rust: find one `#[test]` or example that opens no camera

## Why this exists

"It worked on my video" is not a contribution.
Lesson 12 will ask you to open a PR against Candle or opencv-rust.
Maintainers will look for rustfmt, clippy, rustdoc on public items, and tests that do not need a GPU or a webcam.

## You write

Bring the workspace to contribution shape:

- Unit tests live next to the code (`#[cfg(test)]`)
- Integration tests in `tests/associate.rs`, `tests/errors.rs`
- Every public function has rustdoc; at least two rustdoc examples that compile (`cargo test --doc`)
- `cargo fmt --all`
- `cargo clippy --workspace --all-targets -- -D warnings`
- A `CONTRIBUTING-STUDENT.md` *you* write: how you will open the upstream PR (fork, branch name, what you will not include)

Required tables:

- IoU fixtures (from lesson 02), including a regression for a bug *you* actually hit
- Association fixtures (from lesson 06)
- `TrackState` transitions (from lesson 04)

Optional but recommended: a `tests/data/` JSONL clip of 10 synthetic frames that lesson 10 will reuse.

## Plan of work

### A. Read

- [ ] Add one `#[should_panic]` only if you have a true invariant; otherwise prefer `Result`

### B. Hygiene

- [ ] `cargo fmt --all -- --check`
- [ ] clippy `-D warnings`
- [ ] `cargo test --workspace --doc`

### C. Notes

- [ ] List Candle's likely CI checks (fmt / test / maybe features)
- [ ] List opencv-rust's likely pain (system OpenCV, clang) and how your PR avoids needing a camera

## Definition of done

A stranger can run `cargo test --workspace` on a machine without a GPU or webcam and get green.
Public API is rustdoc'd.

## Stretch

Run `cargo tarpaulin` or `cargo llvm-cov` if you want a number.
Do not chase 100%. Cover error paths.

## References

- https://doc.rust-lang.org/book/ch11-00-testing.html
- https://doc.rust-lang.org/rustdoc/
- https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust
