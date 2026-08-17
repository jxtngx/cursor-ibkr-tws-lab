# Lessons

Lesson 00 is the toolchain.
Lessons 01–12 go from [Learn Rust](https://www.rust-lang.org/learn/) to a paper-ready MES → ES order-book + strategy crate.

The wire to Interactive Brokers (protobuf / [`ibapi`](https://github.com/wboayue/rust-ibapi) / TWS / Gateway) is **later**.
No lesson connects or submits.

You write every crate.
Agents open `LESSON.md`, quiz you, and review.
They do not implement the exercise.
They do not place orders.

| # | Folder | Official spine | You build | Toward |
| --- | --- | --- | --- | --- |
| 00 | [00-dev-standards](00-dev-standards/LESSON.md) | Appendix D, Clippy, rustfmt, Error Index | fmt / clippy / test / backtrace | the PR toolchain |
| 01 | [01-getting-started](01-getting-started/LESSON.md) | Book 1–2, rustup | Cargo hello, walk TWS + `ibapi` docs | paper ports, no connect |
| 02 | [02-language-foundations](02-language-foundations/LESSON.md) | Book 3, RBE primitives | ticks, multipliers, MES first | contract math |
| 03 | [03-ownership](03-ownership/LESSON.md) | Book 4, rustlings moves | `OrderBook` owns `DOMLevel` | depth callbacks |
| 04 | [04-structs-enums](04-structs-enums/LESSON.md) | Book 5–6 | `Side`, `Tif`, `OrderStatus`, `Inventory` | MES then ES |
| 05 | [05-crates-modules](05-crates-modules/LESSON.md) | Book 7, Cargo Book | `tick` / `book` / `order` / `risk` | later adapter, not inside `book` |
| 06 | [06-collections-iterators](06-collections-iterators/LESSON.md) | Book 8, 13 | L2 insert / update / delete, microprice, imbalance | `reqMarketDepth` |
| 07 | [07-error-handling](07-error-handling/LESSON.md) | Book 9 | paper gates, reject, bad window | risk before a socket exists |
| 08 | [08-traits-lifetimes](08-traits-lifetimes/LESSON.md) | Book 10 | `MarketData`, `OrderRouter`, `Quoter` | inventory-aware MM |
| 09 | [09-tests-docs](09-tests-docs/LESSON.md) | Book 11, rustdoc | replay fixtures, rustdoc | CI without TWS |
| 10 | [10-cli-io](10-cli-io/LESSON.md) | Book 12, CLI book | `lob` on JSONL | operator binary |
| 11 | [11-concurrency](11-concurrency/LESSON.md) | Book 15–16 | feed / book / quoter; velocity | async later |
| 12 | [12-paper-readiness](12-paper-readiness/LESSON.md) | Book 20 as needed | session + lunch, force-flat, protobuf sketch | ready to wire |

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
- A complete `OrderBook`, quoter, or `ibapi` client dumped into this repo as a solution.
- Skipping lesson 00 because the tools look obvious.
- Skipping the Book chapter because the domain hook looks more fun.
- Adding `ibapi` / `prost`, connecting to TWS, or submitting an order.
