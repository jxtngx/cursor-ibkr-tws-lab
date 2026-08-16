# Lesson 01 — Getting started

> Official spine: [Learn Rust](https://www.rust-lang.org/learn/) · [Book ch. 1](https://doc.rust-lang.org/book/ch01-00-getting-started.html) · [Book ch. 2](https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html) · [Install](https://www.rust-lang.org/learn/get-started)
> Companion: [Rustlings](https://github.com/rust-lang/rustlings/) setup
> Wire: [TWS API introduction](https://interactivebrokers.github.io/tws-api/introduction.html) · [`ibapi` README](https://github.com/wboayue/rust-ibapi) · [ib-interface](https://github.com/jxtngx/ib-interface) (Python, read-only)
> Domain hook: you cannot call TWS if Cargo is still magic, and you cannot call live TWS in this lab at all

Prerequisite: [lesson 00](../00-dev-standards/LESSON.md). `cargo fmt`, clippy, and `RUST_BACKTRACE` should already be ordinary.

## Contract

You type the program.
The tutor may explain `cargo new` and the compiler's first errors.
The tutor may not finish the guessing-game chapter for you.
The tutor may not write a TWS client.

## Read first (do not skip)

- [ ] Lesson 00 `NOTES.md` exists (fmt, clippy, a backtrace). If not, stop and finish 00
- [ ] [Learn Rust](https://www.rust-lang.org/learn/) landing page — know what the Book, Rust by Example, and Rustlings each are
- [ ] Book ch. 1 — install, Hello world, Hello Cargo
- [ ] Book ch. 2 — the guessing game, *typed by you*
- [ ] Install Rustlings and run the first exercise only (do not binge)
- [ ] TWS API introduction — what TWS / IB Gateway is, that the API is a socket to *that* process
- [ ] `ibapi` README: sync vs async features, `Client::connect`, `Contract::futures`
- [ ] Skim [ib-interface](https://github.com/jxtngx/ib-interface) README so you know it is your *Python* TWS lab, not something to rewrite in Rust this week

## Why this exists

`ibapi` is a crate that speaks the TWS socket protocol.
TWS / Gateway must be running, API port enabled, paper account logged in.
If `cargo build` is still magic, every later lesson is theater.
This lesson makes Cargo ordinary, then forces you to *look* at the two docs you will live in: the official TWS API and `ibapi`.

## You write

```bash
cd lessons/01-getting-started
cargo init --name lesson01
```

Deliverables:

1. A binary that prints a one-line greeting and `env!("CARGO_PKG_NAME")`.
2. The Book ch. 2 guessing game, in this crate (or `src/bin/guess.rs`).
3. A short `NOTES.md` *you* write, not an agent:
   - Paper TWS port **7497** and paper Gateway port **4002**. Live 7496 / 4001 are forbidden
   - How `ibapi` 3.x is added (`ibapi = "3.3"` or the sync feature). You do **not** add it to this crate yet
   - Where `Contract::futures("ES")` lives in the README
   - One sentence: ib-interface is Python + official `ibapi` protobuf; this lab uses the *Rust* `ibapi` crate in lesson 12
   - You do **not** need TWS running yet

## Plan of work

### A. Toolchain

- [ ] `rustc --version` and `cargo --version` work (stable)
- [ ] rustfmt + clippy still installed from 00

### B. Book work

- [ ] Hello Cargo from ch. 1
- [ ] Guessing game from ch. 2, including `rand`, `parse`, and the `match` on `Ordering`

### C. Upstream walk (read-only)

- [ ] Open the TWS API intro and the market-depth page. Do not code them
- [ ] Open `ibapi` on docs.rs / GitHub. Note sync vs async
- [ ] Write `NOTES.md`

### D. Check

- [ ] `cargo test`
- [ ] `cargo clippy --all-targets -- -D warnings`
- [ ] `@review-rust` on *your* diff

## Definition of done

You can recreate the guessing game from a blank file.
You can point at paper vs live ports and say which crate you will add in lesson 12.

## Stretch

Install TWS or IB Gateway **paper** and enable the API port.
Do not connect from Rust yet.
Record in `NOTES.md` whether the paper login works.

## References

- https://www.rust-lang.org/learn/
- https://doc.rust-lang.org/book/ch01-00-getting-started.html
- https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html
- https://interactivebrokers.github.io/tws-api/introduction.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
- https://github.com/wboayue/rust-ibapi
- https://docs.rs/ibapi/
- https://github.com/jxtngx/ib-interface
