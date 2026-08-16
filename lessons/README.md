# Lessons

Lesson 00 is the toolchain.
Lessons 01–12 go from [Learn Rust](https://www.rust-lang.org/learn/) to a paper MES → ES limit-order book on Interactive Brokers via [`ibapi`](https://github.com/wboayue/rust-ibapi).

You write every crate.
Agents open `LESSON.md`, quiz you, and review.
They do not implement the exercise.
They do not place orders.

| # | Folder | Official spine | You build | Wire it prepares |
| --- | --- | --- | --- | --- |
| 00 | [00-dev-standards](00-dev-standards/LESSON.md) | Appendix D, Clippy, rustfmt, Error Index | fmt / clippy / test / backtrace | the PR toolchain |
| 01 | [01-getting-started](01-getting-started/LESSON.md) | Book 1–2, rustup | Cargo hello, walk TWS API + `ibapi` | paper ports, no live |
| 02 | [02-language-foundations](02-language-foundations/LESSON.md) | Book 3, RBE primitives | ticks, multipliers, MES↔ES size | contract math |
| 03 | [03-ownership](03-ownership/LESSON.md) | Book 4, rustlings moves | owned book, borrowed update | depth callbacks |
| 04 | [04-structs-enums](04-structs-enums/LESSON.md) | Book 5–6 | `Side`, `Tif`, `OrderStatus`, `FuturesSpec` | MES/ES/CL |
| 05 | [05-crates-modules](05-crates-modules/LESSON.md) | Book 7, Cargo Book | workspace `tick` / `book` / `order` | `ibapi` module map |
| 06 | [06-collections-iterators](06-collections-iterators/LESSON.md) | Book 8, 13 | L2 insert / update / delete | `reqMarketDepth` |
| 07 | [07-error-handling](07-error-handling/LESSON.md) | Book 9 | disconnect, reject, paper guard | TWS error codes |
| 08 | [08-traits-lifetimes](08-traits-lifetimes/LESSON.md) | Book 10 | `MarketData` + `OrderRouter` | stub now, `ibapi` later |
| 09 | [09-tests-docs](09-tests-docs/LESSON.md) | Book 11, rustdoc | replay fixtures, rustdoc | CI without TWS |
| 10 | [10-cli-io](10-cli-io/LESSON.md) | Book 12, CLI book | `lob` on JSONL depth | operator binary |
| 11 | [11-concurrency](11-concurrency/LESSON.md) | Book 15–16 | feed / book / router threads | `ibapi` subscriptions |
| 12 | [12-paper-tws](12-paper-tws/LESSON.md) | Book 20, Nomicon 1–3 | paper `ibapi` MES→ES limit | one paper order |

## How to start a lesson

1. Read the official links in that `LESSON.md` *before* you prompt.
2. `@start-lesson 00` (then 01, or the next unfinished number).
3. Create the crate yourself:

```bash
cd lessons/00-dev-standards
cargo init --lib --name lesson00
```

4. Write the tests first when the lesson says so.
5. `@review-rust` only after `cargo test` is green.

## What must not happen

- An agent filling `src/` because you asked it to "just make it compile."
- A complete book, router, or `ibapi` client dumped into this repo as a solution.
- Skipping lesson 00 because the tools look obvious.
- Skipping the Book chapter because the domain hook looks more fun.
- Connecting to live TWS (7496 / 4001) or submitting a live order.
