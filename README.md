# Cursor IBKR TWS Lab

Learn Rust with SuperGrok and Cursor.
This repo is a lab, not a product factory.
You read the official materials, you write the code, you sit with the compiler until it makes sense.
SuperGrok and Cursor are the tutor and the reviewer.
They are not allowed to do the work for you.

> **Audience.** You are a beginner who intends to become an advanced Rust user quickly.
> You have a [SuperGrok](https://grok.com) subscription and [Cursor](https://cursor.com) open on this repo.
> You will type every function yourself.
>
> **Bias.** Interaction over generation.
> The official tutorial over homemade curricula.
> Depth over a finished crate that you cannot explain.

This is the same contract as [cuda-spatial-intelligence-lab](https://github.com/jxtngx/cuda-spatial-intelligence-lab): a Cursor-native lab where the student does the work.
It is the opposite of [cursor-fullstack-template](https://github.com/jxtngx/cursor-fullstack-template) and [deep-learning-with-cursor](https://github.com/jxtngx/deep-learning-with-cursor), whose harnesses are built to implement tickets.
If an agent opens a PR with a complete solution you did not write, the lab failed.

The destination is a **clean, well-tested order-book + strategy crate** for MES → ES (and later other equity-index and commodity futures).
Every lesson builds a piece of that crate: `DOMLevel`, L2 `OrderBook`, microprice, imbalance, inventory-aware quoting, session and velocity filters, force-flat, paper risk gates.
It is written so it can *later* be wired to Interactive Brokers TWS / Gateway via protobuf ([TWS API](https://interactivebrokers.github.io/tws-api/introduction.html), [`ibapi`](https://github.com/wboayue/rust-ibapi) or prost-generated types).
This lab does **not** add that wire yet.
No `Client::connect`. No live or paper order submit. Fixtures and stubs only.

This is not trading advice.
A quoting function that compiles is not a license to size it like a desk.

---

## What this repo is

A thin Cursor harness around the official [Learn Rust](https://www.rust-lang.org/learn/) path.
The spine is [The Rust Programming Language](https://doc.rust-lang.org/book/) ("the Book").
[Rustlings](https://github.com/rust-lang/rustlings/) and [Rust by Example](https://doc.rust-lang.org/rust-by-example/) are the drills.
The [standard library](https://doc.rust-lang.org/std/), [Cargo Book](https://doc.rust-lang.org/cargo/), and later the [Rustonomicon](https://doc.rust-lang.org/nomicon/) are how beginners become advanced users without a side quest of blog posts.

Thirteen lesson specs live in [`lessons/`](lessons/README.md) (00 is the toolchain).
They are specs, not solutions.
You create each crate with `cargo init` and write the tests.

What lives here:

- **`lessons/`** — `LESSON.md` files from toolchain (00) to paper-ready risk gates (12).
- **`.cursor/agents/`** — tutor, engineer, test developer, architect, scrum master.
  The tutor explains one concept and stops.
  The engineer and test developer review *your* code.
  None of them implement the lesson.
- **`.cursor/commands/`** — `@start-lesson`, `@explain-concept`, `@review-rust`, `@run-ticket-plan`.
  `@start-lesson` opens the spec.
  `@run-ticket-plan` shows the next ticket and stops.
- **`.cursor/rules/`** — always-on: no emojis, incremental changes, rustfmt + clippy, `cargo test` is the source of truth, no `unwrap` in library paths, no clone-to-compile, **paper trading only**.
- **`.cursor/skills/`** — [dev standards](.cursor/skills/rust-dev-standards.md), ownership, `Result`, traits, lifetimes, modules, Cargo, and the [curriculum plan](.cursor/skills/curriculum-plan/SKILL.md).

There is no multi-agent product pipeline here.
There is no "implement the sprint" loop.
If you want that, use the fullstack or deep-learning repos.

## The 13 lessons

Official index: [rust-lang.org/learn](https://www.rust-lang.org/learn/).
Full table: [lessons/README.md](lessons/README.md).

| # | Lesson | Official spine | Toward |
| --- | --- | --- | --- |
| 00 | [Dev standards](lessons/00-dev-standards/LESSON.md) | Appendix D, Clippy, rustfmt, Error Index | fmt, clippy, test, backtrace |
| 01 | [Getting started](lessons/01-getting-started/LESSON.md) | Book 1–2, rustup | Walk TWS API + `ibapi` docs (no connect) |
| 02 | [Language foundations](lessons/02-language-foundations/LESSON.md) | Book 3, RBE primitives | ticks, multipliers, MES first |
| 03 | [Ownership](lessons/03-ownership/LESSON.md) | Book 4 | `OrderBook` owns `DOMLevel` |
| 04 | [Structs and enums](lessons/04-structs-enums/LESSON.md) | Book 5–6 | `Side`, `Tif`, `OrderStatus`, `Inventory` |
| 05 | [Crates and modules](lessons/05-crates-modules/LESSON.md) | Book 7, Cargo Book | `tick` / `book` / `order` / `risk` |
| 06 | [Collections and iterators](lessons/06-collections-iterators/LESSON.md) | Book 8, 13 | L2 insert/update/delete, microprice, imbalance |
| 07 | [Error handling](lessons/07-error-handling/LESSON.md) | Book 9 | paper risk gates, rejects |
| 08 | [Traits and lifetimes](lessons/08-traits-lifetimes/LESSON.md) | Book 10 | `MarketData`, `OrderRouter`, inventory quoter |
| 09 | [Tests and rustdoc](lessons/09-tests-docs/LESSON.md) | Book 11, rustdoc | replay fixtures, the PR bar |
| 10 | [CLI and I/O](lessons/10-cli-io/LESSON.md) | Book 12, CLI book | `lob` replay + quote print |
| 11 | [Concurrency](lessons/11-concurrency/LESSON.md) | Book 15–16 (17 stretch) | feed / book / quoter; velocity filter |
| 12 | [Paper readiness](lessons/12-paper-readiness/LESSON.md) | Book 20 as needed | session windows, force-flat, protobuf sketch |

All thirteen lessons are offline.
They use fixtures and stubs.
No lesson adds `ibapi` to `Cargo.toml`, opens a socket, or submits an order.
The *crate you write* is what you will later wire to paper TWS / Gateway via protobuf.

MES is one-tenth the notional of ES (multiplier $5 vs $50, same $0.25 tick).
You prove size conversion and book logic on MES before ES is more than a second `FuturesSpec`.

## How you are supposed to work

```
read the chapter  →  attempt the exercise  →  ask SuperGrok / Cursor  →  fix *your* code  →  cargo test
```

1. Open `lessons/NN-*/LESSON.md` and read the official links *before* you prompt.
2. Write a failing test or a broken program yourself.
3. Ask SuperGrok or Cursor to explain the compiler error, not to paste the solution.
4. Change the code yourself.
5. Run `cargo test` and `cargo clippy --all-targets -- -D warnings`.
6. Only then use `@review-rust`.
   Review is a critique of your diff, not a rewrite.

### What the harness may do

- Point at the exact Book chapter, Rustlings exercise, `std` item, or TWS API page.
- Explain a compiler error in your words, then ask you what the ownership model is.
- Sketch a 10–20 line example of *the concept*, never the finished book or order router.
- Review a diff you wrote and refuse clone-to-compile, hidden `unwrap`, unexplained `unsafe`, and live-port constants.

### What the harness must not do

- Implement `@start-lesson` or `@run-ticket-plan` tickets.
- Fill in `lessons/` or `crates/` because you asked it to "just make it compile."
- Dump a complete limit-order book, `ibapi` client, or MES→ES strategy.
- Skip ownership because it is annoying.
- Invent a parallel curriculum that replaces the Book.
- Connect to TWS (paper or live) or submit an order. The wire is later, outside this syllabus.

If SuperGrok or Cursor starts writing the solution, stop it and ask for the question instead.

## Official spine

Do not replace these with a custom syllabus.
Lean on them in this order.

| Stage | Official material | Lessons |
| --- | --- | --- |
| Tools | [Appendix D](https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html), [Clippy](https://doc.rust-lang.org/clippy/), [rustfmt](https://rust-lang.github.io/rustfmt/), [Error Index](https://doc.rust-lang.org/error-index.html) | 00 |
| Start | [Install](https://www.rust-lang.org/learn/get-started) + Book ch. 1–3 | 01–02 |
| Own it | Book ch. 4–6 + [Rustlings](https://github.com/rust-lang/rustlings/) | 03–04 |
| Structure | Book ch. 7–11 | 05–09 |
| Build | Book ch. 12–14 + [Cargo Book](https://doc.rust-lang.org/cargo/) + [CLI book](https://rust-cli.github.io/book/) | 10 |
| Systems | Book ch. 15–17 | 11 |
| Ready | Session / velocity / force-flat + a protobuf *sketch* (no socket). [TWS API](https://interactivebrokers.github.io/tws-api/introduction.html) and [`ibapi`](https://docs.rs/ibapi/) are reading, not dependencies | 12 |

Companion drills, used *with* the chapter, not instead of it:

- [Learn Rust](https://www.rust-lang.org/learn/) — official index
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/) — short programs when the Book is too much prose
- [Compiler Error Index](https://doc.rust-lang.org/error-index.html) — every `E0xxx` you hit
- [Edition Guide](https://doc.rust-lang.org/edition-guide/) — this repo targets current stable / edition 2024
- [TWS API: market depth](https://interactivebrokers.github.io/tws-api/market_depth.html) — insert / update / delete
- [TWS API: contracts](https://interactivebrokers.github.io/tws-api/basic_contracts.html) · [orders](https://interactivebrokers.github.io/tws-api/basic_orders.html)
- [`ibapi` crate](https://github.com/wboayue/rust-ibapi) — the Rust client you will wire *after* this lab
- [ib-interface](https://github.com/jxtngx/ib-interface) — your Python TWS reference (read-only). Do not port it.

## Daily loop in Cursor

1. `@start-lesson 00` — the Rust Tutor opens the spec, checks that you read Appendix D, and stops. Then 01.
2. You `cargo init` in that folder and write the code.
3. `@explain-concept <idea>` when you are stuck on *one* idea.
4. `@review-rust` after `cargo test` is green.
   Fix what it flags yourself.
5. `@run-ticket-plan` only to see what is next.

Keep SuperGrok in the same loop: ask it to quiz you, not to author the crate.
A useful prompt is "I read Book chapter N. Here is my code and the rustc error. Do not write the fix. Ask me three questions that force the right model."

## Tooling baseline

- **rustup** stable, current edition (2024).
- **cargo**, **rustfmt**, **clippy**, **rust-analyzer** in Cursor.
- **No extra crates** until the lesson that names them.
  Prefer `std`.
  `ibapi` / `prost` are *after* this lab, not in `Cargo.toml` here.
- TWS or IB Gateway is optional reading. You do not connect from these lessons.
  Paper ports (TWS **7497**, Gateway **4002**) exist so you can recognize them. Live 7496 / 4001 are forbidden even as defaults.
- Open this repo in Cursor so `.cursor/` rules, agents, and commands load.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt clippy rust-analyzer
cargo --version
```

## Repo layout

```
.cursor/
  agents/      # tutor and reviewers — they do not implement
  commands/    # start-lesson, explain-concept, review-rust
  rules/       # always-on Rust, lab, and paper-only rules
  skills/      # Book-aligned notes + curriculum-plan
lessons/
  README.md
  00-dev-standards/LESSON.md
  01-getting-started/LESSON.md
  ...
  12-paper-readiness/LESSON.md
  */src/       # you create these
```

## Definition of done for a lesson

A lesson is done when *you* can do all of this without the model in the room:

- [ ] State the Book chapter and the one concept in a sentence
- [ ] Explain the last rustc error you hit and why the fix is the model, not a workaround
- [ ] `cargo test` and `cargo clippy --all-targets -- -D warnings` are clean
- [ ] No `unwrap` you cannot defend, no `clone` that exists to silence the borrow checker
- [ ] You can write the same program again from a blank file
- [ ] No TWS port in source, no account number, no order submit, no `ibapi` dependency

If you cannot, you are not done, even if the tests pass because an agent wrote them.

## License

Apache-2.0. See [LICENSE](LICENSE).
