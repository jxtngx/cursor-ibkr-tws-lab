# Lesson 01 — Getting started

> Official spine: [Learn Rust](https://www.rust-lang.org/learn/) · [Book ch. 1](https://doc.rust-lang.org/book/ch01-00-getting-started.html) · [Book ch. 2](https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html) · [Install](https://www.rust-lang.org/learn/get-started)
> Companion: [Rustlings](https://github.com/rust-lang/rustlings/) setup
> Contribution target: literacy in both upstream repos
> Domain hook: you cannot contribute to Candle or opencv-rust if you cannot build *this* crate

## Contract

You type the program.
The tutor may explain `cargo new` and the compiler's first errors.
The tutor may not finish the guessing-game chapter for you.

## Read first (do not skip)

- [ ] [Learn Rust](https://www.rust-lang.org/learn/) landing page — know what the Book, Rust by Example, and Rustlings each are
- [ ] Book ch. 1 — install, Hello world, Hello Cargo
- [ ] Book ch. 2 — the guessing game, *typed by you*
- [ ] Install Rustlings and run the first exercise only (do not binge)

## Why this exists

Candle is a Cargo workspace.
opencv-rust is a crate that talks to a C++ library through a binding generator.
If `cargo build` is still magic, every later lesson is theater.
This lesson makes Cargo and rustc ordinary, then forces you to *look* at the two repos you will eventually patch.

## You write

Create the crate in this folder (not at the repo root):

```bash
cd lessons/01-getting-started
cargo init --name lesson01
```

Deliverables:

1. A binary that prints a one-line greeting and the output of `env!("CARGO_PKG_NAME")`.
2. The Book ch. 2 guessing game, in this crate (or a second binary via `src/bin/guess.rs`).
3. A short `NOTES.md` *you* write, not an agent:
   - How to build [huggingface/candle](https://github.com/huggingface/candle) (clone path, `cargo test -p candle-core --lib` or the command that actually worked)
   - How to read [twistedfall/opencv-rust](https://github.com/twistedfall/opencv-rust) (`INSTALL.md`, `videoio` feature)
   - One sentence on where `candle-examples/examples/yolo-v8` and `candle-examples/examples/dinov2` live
   - You do **not** need OpenCV or CUDA installed yet

## Plan of work

### A. Toolchain

- [ ] `rustc --version` and `cargo --version` work (stable)
- [ ] `rustup component add rustfmt clippy rust-analyzer`

### B. Book work

- [ ] Hello Cargo from ch. 1
- [ ] Guessing game from ch. 2, including `rand`, `parse`, and the `match` on `Ordering`

### C. Upstream walk (read-only)

- [ ] Clone Candle and opencv-rust *outside* this repo (or add them as documented remotes). Do not vendor them here.
- [ ] Skim Candle's top-level README: `candle-core`, `candle-nn`, `candle-transformers`, `candle-examples`
- [ ] Skim opencv-rust README: binding-generator, `Mat`, features (`videoio`, `imgproc`)
- [ ] Write `NOTES.md`

### D. Check

- [ ] `cargo test` (even if you only have the default test)
- [ ] `cargo clippy --all-targets -- -D warnings`
- [ ] `@review-rust` on *your* diff

## Definition of done

You can recreate the guessing game from a blank file.
You can point at the Candle crate that would hold an RF-DETR model (`candle-transformers`) and the opencv module that would hold `VideoCapture` (`videoio`).

## Stretch

Run one Candle *CPU* example that already exists (YOLO-v8 or DINOv2) if your machine allows it.
Record the command and the failure if it fails.
Do not debug CUDA this week.

## References

- https://www.rust-lang.org/learn/
- https://doc.rust-lang.org/book/ch01-00-getting-started.html
- https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust
- https://github.com/roboflow/rf-detr
