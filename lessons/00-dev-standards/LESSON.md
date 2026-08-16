# Lesson 00 — Dev standards

> Official spine: [Book Appendix D](https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html) · [Cargo tests](https://doc.rust-lang.org/cargo/guide/tests.html) · [Clippy](https://doc.rust-lang.org/clippy/) · [rustfmt](https://rust-lang.github.io/rustfmt/) · [Compiler Error Index](https://doc.rust-lang.org/error-index.html) · [rustc codegen](https://doc.rust-lang.org/rustc/codegen-options/index.html)
> Companion: [rust-analyzer](https://rust-analyzer.github.io/manual.html) in Cursor · `rust-gdb` / `rust-lldb` (ship with rustup)
> Contribution target: Candle and opencv-rust both assume rustfmt, clippy, and `cargo test` before a human looks at the PR
> Domain hook: none yet. If you cannot read a rustc error or a panic backtrace, later IoU and ByteTrack bugs will look like "the compiler is being mean"

This lesson is the bench, not a language chapter.
You set up the same tools you will use in 01–12 and prove you can drive them.

## Contract

You run every command.
The tutor may name the official flag.
The tutor may not fill `NOTES.md` or write the panic you are supposed to read.

## Read first (do not skip)

- [ ] [Book Appendix D](https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html) — rustfmt, rustfix / `cargo fix`, Clippy, rust-analyzer
- [ ] [Cargo: tests](https://doc.rust-lang.org/cargo/guide/tests.html) and the start of [Book ch. 11](https://doc.rust-lang.org/book/ch11-00-testing.html) (you will do ch. 11 properly in lesson 09)
- [ ] [Clippy book](https://doc.rust-lang.org/clippy/) — what a lint is, `allow` vs fixing the code
- [ ] [rustfmt](https://rust-lang.github.io/rustfmt/) — config knobs exist; the default style is the lab style
- [ ] [Compiler Error Index](https://doc.rust-lang.org/error-index.html) — how to look up `E0xxx`
- [ ] rustc codegen: `debuginfo`, `opt-level` ([docs](https://doc.rust-lang.org/rustc/codegen-options/index.html))
- [ ] rust-analyzer in Cursor: set `rust-analyzer.check.command` to `clippy`

## Why this exists

rustc is the first reviewer.
Clippy is the second.
A Candle or opencv-rust maintainer is the third.
If rustfmt is a surprise in lesson 09, you wasted eight lessons.
This module is how you become someone those maintainers can review.

## You write

```bash
cd lessons/00-dev-standards
cargo init --lib --name lesson00
```

The crate is a playground, not a product.

You will also write `NOTES.md` in this folder.
Every section below ends with something you paste or explain there.
If `NOTES.md` is empty, the lesson is not done even if tests are green.

## Plan of work

### A. Toolchain

- [ ] `rustc --version`, `cargo --version` (stable)
- [ ] `rustup component add rustfmt clippy rust-analyzer`
- [ ] `rustfmt --version` and `cargo clippy --version`
- [ ] In `NOTES.md`: those three version lines

### B. Formatter — rustfmt

- [ ] Write a deliberately ugly function (odd indent, smashed braces)
- [ ] `cargo fmt -- --check` — it must fail
- [ ] `cargo fmt`
- [ ] `cargo fmt -- --check` — it must pass
- [ ] In `NOTES.md`: three lines of before and after. Do not add a custom `rustfmt.toml` unless you can name the one knob you changed

Lab default is rustfmt's default.
Do not invent a house style.

### C. Linters — rustc + Clippy + rustfix

- [ ] Write something Clippy hates on purpose (`unwrap` on a literal `Some`, or a `clone` of `Copy`, or an unused `mut`)
- [ ] `cargo clippy --all-targets -- -D warnings` — it must fail
- [ ] Fix the code, not `#[allow(...)]`, unless you write *why* the allow is correct
- [ ] Run `cargo fix --lib` on a warning rustc can apply (`cargo fix` is rustfix; Appendix D)
- [ ] `cargo clippy --all-targets -- -D warnings` green
- [ ] In `NOTES.md`: the lint name (`clippy::...`) and the model it was enforcing

### D. Tests — cargo test

- [ ] One unit test in `src/lib.rs` (`#[cfg(test)]`)
- [ ] One integration test in `tests/smoke.rs`
- [ ] One rustdoc example that `cargo test --doc` runs
- [ ] `cargo test` — all three kinds run
- [ ] `cargo test smoke` — filter by name
- [ ] `cargo test -- --nocapture` — see a `println!` you put in a test
- [ ] Write a test that fails on purpose, read the assertion output, then fix it
- [ ] In `NOTES.md`: which of the three test kinds would you use for IoU later, and why

### E. Stack traces — panic and `RUST_BACKTRACE`

- [ ] A public function that `panic!`s with a message you chose (a binary `src/bin/boom.rs` is fine)
- [ ] `cargo run --bin boom` with default env — copy the short message
- [ ] `RUST_BACKTRACE=1 cargo run --bin boom` — copy the *top* frame (`lesson00::...` file:line)
- [ ] `RUST_BACKTRACE=full cargo run --bin boom` — one sentence on what "full" added
- [ ] Look up the panic in your source. Confirm the line number matches
- [ ] In `NOTES.md`: paste the top frame and explain each field (crate, module, function, file, line)

A backtrace is not a novel.
Read from the top until you hit *your* code. Frames in `std` and `core` are context, not the bug.

### F. Debugging — `dbg!`, then a real debugger

- [ ] Replace the panic with a wrong return value. Find it with `dbg!` (or `eprintln!("{:?}", ...)`). Then delete the `dbg!`
- [ ] Hit a breakpoint in Cursor (rust-analyzer / CodeLLDB) **or** run `rust-lldb` / `rust-gdb` on the binary
- [ ] Step over one line. Inspect one local
- [ ] In `NOTES.md`: which debugger, the command or click path, and the value you saw

If the debugger will not start, do not stall the lesson.
Record the exact error, use `dbg!` + backtrace for now, and come back.
A working `RUST_BACKTRACE` plus `dbg!` is enough to advance; a working breakpoint is the standard.

### G. Profiling — debug vs release, then a timer

Never time a debug build and call it performance.

- [ ] A function that does a few million adds or a naive `O(n^2)` you can feel
- [ ] Time it with `std::time::Instant` under `cargo run` (debug)
- [ ] Time the same function under `cargo run --release`
- [ ] In `NOTES.md`: both wall times and the `opt-level` that `--release` uses (look it up in the rustc book)
- [ ] One sentence: why you will not "optimize" IoU until you have a test and a release timing
- [ ] Optional stretch: `cargo install flamegraph` and `cargo flamegraph --bin ...` if `perf` works on your machine. Paste nothing huge — name the hottest frame

`cargo bench` / Criterion is allowed as stretch.
It is not required. `Instant` plus `--release` is the official-enough habit.

### H. Reading rustc — Error Index

- [ ] Write a program that will not compile. Prefer a real beginner error: use-after-move (`E0382`), type mismatch (`E0308`), or unused `Result` (`must_use`)
- [ ] Copy the *first* error only. Ignore the cascade
- [ ] Open that code in the [Error Index](https://doc.rust-lang.org/error-index.html)
- [ ] Fix it by changing the model (ownership, type, or handling the `Result`), not by `clone` or `unwrap` unless you can defend it
- [ ] In `NOTES.md`: error code, one-sentence official meaning, one-sentence what *you* did wrong

### I. Beginner gotchas — trigger, do not memorize

Work through **at least five**. For each: broken snippet (in comments or a `gotchas` module), the rustc/clippy code, the fix, one line on the model.

| # | Gotcha | What you must see |
| --- | --- | --- |
| 1 | Unused `Result` | rustc `must_use` / "unused `Result` that must be used" |
| 2 | `String` vs `&str` | `E0308` expected `&str`, found `String` (or the reverse) |
| 3 | Missing `mut` | `E0596` cannot borrow as mutable |
| 4 | Use after move | `E0382` |
| 5 | Integer overflow | panic in debug; wrapping or a different result in `--release` if you use `+` on a value that overflows. **Observe both.** Do not ship overflow on purpose |
| 6 | `clone` to compile | It compiles. Clippy or your reviewer should hate it. Write why the clone is a lie |
| 7 | `unwrap` in library code | Green tests, red review. Replace with `?` or `Option` |
| 8 | rust-analyzer looks fine, `cargo clippy -D warnings` is not | The editor is not CI. Trust the command |
| 9 | `cargo run` vs `cargo test` | A `println!` in `lib.rs` is not a test. Prove it |
| 10 | Debug timing | You already did this in G. Do not file a "perf bug" from an unoptimized build |

Five is the bar.
Ten is better.
Paste the table into `NOTES.md` with your error codes filled in.

## Definition of done

You can do all of this without the model in the room:

- [ ] `cargo fmt -- --check` clean
- [ ] `cargo clippy --all-targets -- -D warnings` clean
- [ ] `cargo test` (unit + integration + doc) green
- [ ] You can read a `RUST_BACKTRACE=1` frame out loud
- [ ] `NOTES.md` has versions, one rustfmt before/after, one lint name, one backtrace frame, one rustc error code, and five gotchas
- [ ] You did not leave `dbg!` or a deliberate panic in the default `lib` path

## What this lesson is not

- A second copy of Book ch. 11 (that is lesson 09)
- Permission to add Criterion, tokio-console, or Valgrind as required deps
- A house style guide that replaces rustfmt

## Stretch

- Turn on rust-analyzer Clippy-on-save in Cursor and show a screenshot in `NOTES.md` (optional)
- Read `cargo test --help` and name three flags you did not use
- Skim how Candle CI names `fmt` / `clippy` / `test` so lesson 12 is not a surprise

## References

- https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html
- https://doc.rust-lang.org/cargo/guide/tests.html
- https://doc.rust-lang.org/book/ch11-00-testing.html
- https://doc.rust-lang.org/clippy/
- https://rust-lang.github.io/rustfmt/
- https://doc.rust-lang.org/error-index.html
- https://doc.rust-lang.org/rustc/codegen-options/index.html
- https://rust-analyzer.github.io/manual.html
- rustup wrappers: `rust-gdb`, `rust-lldb` (on your `PATH` after rustup)
