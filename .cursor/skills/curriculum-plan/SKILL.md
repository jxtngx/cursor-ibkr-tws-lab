---
name: curriculum-plan
description: Master 13-lesson Cursor IBKR TWS Lab curriculum (00 toolchain, 01-12 Book to a MES-ES OrderBook + strategy crate). Use when the user asks what lesson they are on, what to read next, or how a lesson maps to DOMLevel, microprice, imbalance, inventory quoting, session filters, force-flat, or later IB protobuf. Open the matching lessons/NN-*/LESSON.md for the spec.
---

# 13-lesson curriculum

Source of truth for sequence: [lessons/README.md](../../../lessons/README.md).
Official language index: [Learn Rust](https://www.rust-lang.org/learn/).
Broker reading: [TWS API](https://interactivebrokers.github.io/tws-api/introduction.html).
Rust client *later*: [`ibapi`](https://github.com/wboayue/rust-ibapi) or prost-generated types.

## Intent

Take a beginner to a well-tested **order-book + strategy crate** (MES first, then ES), without replacing the Book, and without a socket.

Application destination (this lab): `DOMLevel`, L2 `OrderBook` (insert/update/delete), microprice, imbalance, inventory-aware quoting, session filters (pre-market + lunch), velocity / too-fast, force-flat, paper risk gates.

After this lab: wire that crate to IB TWS / Gateway via protobuf. Not here.

## Bias

- Official tutorial over a homemade language syllabus.
- Student types the code. Agents quiz and review.
- Domain types appear early so a later adapter is not a rewrite.
- No TWS, no `ibapi` / `prost` dependency, no order submit in any lesson.
- Live ports (7496 / 4001) are a failed lab even as constants.

## The arc

| Lessons | Theme | Trading concept |
| --- | --- | --- |
| 00 | rustfmt, clippy, test, backtrace | the PR toolchain |
| 01–04 | rustup through enums | ticks; `OrderBook`/`DOMLevel`; `Inventory` |
| 05–08 | crates, iterators, `Result`, traits | L2 + microprice + quoter |
| 09–11 | tests, CLI, threads | replay + velocity |
| 12 | session, force-flat, protobuf *sketch* | paper-ready, still offline |

## Agent rules

When `@start-lesson N` runs:

1. Open `lessons/NN-*/LESSON.md`.
2. Confirm the student has done **Read first**.
3. Explain the one official concept. Ten to twenty lines, not the exercise.
4. Stop. The student creates the crate and writes the tests.
5. After they have a diff, `@review-rust`.

Do not implement `src/`.
Do not write `OrderBook`, `Quoter`, or an `ibapi` client.
Do not connect.

## Rubric (every lesson)

Advance only if the student, not the model, can:

1. Name the Book chapter and the one concept.
2. Explain the last rustc error they hit.
3. Show green `cargo test` and clippy `-D warnings`.
4. Re-type the core function from a blank file.
5. Show no socket, no `ibapi` dep, no order submit.
