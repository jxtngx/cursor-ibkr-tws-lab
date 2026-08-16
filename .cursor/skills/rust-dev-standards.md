---
name: rust-dev-standards
description: Official Rust toolchain habits for this lab. Use when the user asks about rustfmt, clippy, cargo test, RUST_BACKTRACE, rust-gdb/lldb, profiling, or beginner rustc errors. Point at lessons/00-dev-standards/LESSON.md. Do not implement the playground crate.
---

# Dev standards

Source of truth: [lessons/00-dev-standards/LESSON.md](../../../lessons/00-dev-standards/LESSON.md).

Official only:

| Job | Tool | Docs |
| --- | --- | --- |
| Format | rustfmt / `cargo fmt` | https://rust-lang.github.io/rustfmt/ · Book Appendix D |
| Lint | Clippy / `cargo clippy --all-targets -- -D warnings` | https://doc.rust-lang.org/clippy/ |
| Auto-fix rustc warnings | rustfix / `cargo fix` | Book Appendix D |
| Test | `cargo test` (unit, `tests/`, rustdoc) | https://doc.rust-lang.org/cargo/guide/tests.html |
| IDE | rust-analyzer, check command = clippy | https://rust-analyzer.github.io/manual.html |
| Panic | `RUST_BACKTRACE=1` or `full` | rustc runtime message |
| Debugger | `rust-gdb` / `rust-lldb` or Cursor + CodeLLDB | rustup wrappers |
| Profile | `Instant` + `cargo run --release` first | rustc `opt-level` |
| Errors | first `E0xxx` in the Error Index | https://doc.rust-lang.org/error-index.html |

## Tutor rules

- Name the official command. Do not invent a wrapper script.
- Prefer fixing the model over `#[allow]`, `clone`, or `unwrap`.
- rustfmt default style. No house `rustfmt.toml` unless the student can defend one knob.
- Do not time debug builds and call it performance.
- Read a backtrace from the top until the student's crate appears.
