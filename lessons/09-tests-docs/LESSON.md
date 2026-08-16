# Lesson 09 — Tests and rustdoc: the bar without TWS

> Official spine: [Book ch. 11](https://doc.rust-lang.org/book/ch11-00-testing.html) · [rustdoc book](https://doc.rust-lang.org/rustdoc/) · [Cargo Book — tests](https://doc.rust-lang.org/cargo/guide/tests.html)
> Companion: Rustlings tests; clippy; rustfmt
> Wire: `ibapi` and IBKR maintainers will not run your paper account in CI. Replay is the bar
> Domain hook: table-driven book apply + order state + MES↔ES size

## Contract

The tutor reviews coverage gaps.
The tutor does not write the tables.
No adhoc `check_*.rs` scripts (see `.cursor/rules/proper-tests.mdc`).

## Read first (do not skip)

- [ ] Book ch. 11 — unit tests, integration tests, `#[should_panic]`, `Result` in tests
- [ ] rustdoc book: what makes a doc-test
- [ ] One `ibapi` example or test naming style (from the repo / docs.rs)

## Why this exists

"It worked on my TWS" is not a contribution and is not a lab.
Lesson 12 will open a paper socket.
Until then — and in CI forever — the book must replay.

## You write

Bring the workspace to contribution shape:

- Unit tests next to the code
- Integration tests in `tests/book_replay.rs`, `tests/orders.rs`, `tests/paper_port.rs`
- Every public function has rustdoc; at least two rustdoc examples that compile (`cargo test --doc`)
- `cargo fmt --all`
- `cargo clippy --workspace --all-targets -- -D warnings`
- A `CONTRIBUTING-STUDENT.md` *you* write: how you will run lesson 12 (paper only), what you will not commit (account ids)

Required tables:

- Book fixtures (lesson 06), including a regression for a bug *you* actually hit
- Order status transitions (lesson 04)
- MES↔ES size (lesson 02)
- `parse_port` live-vs-paper (lesson 07)

`tests/data/` JSONL depth tape that lesson 10 will reuse.

## Plan of work

### A. Read

- [ ] Add one `#[should_panic]` only if you have a true invariant; otherwise prefer `Result`

### B. Hygiene

- [ ] `cargo fmt --all -- --check`
- [ ] clippy `-D warnings`
- [ ] `cargo test --workspace --doc`

### C. Notes

- [ ] How you will keep lesson 12 tests split: `#[ignore]` or a feature `paper-tws` so default `cargo test` needs no broker

## Definition of done

A stranger can run `cargo test --workspace` on a machine without TWS and get green.
Public API is rustdoc'd.
Live ports still fail closed.

## Stretch

`cargo llvm-cov` or tarpaulin if you want a number.
Do not chase 100%. Cover error paths.

## References

- https://doc.rust-lang.org/book/ch11-00-testing.html
- https://doc.rust-lang.org/rustdoc/
- https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html
- https://github.com/wboayue/rust-ibapi
