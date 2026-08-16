---
name: curriculum-plan
description: Master 13-lesson Cursor Rust Lab curriculum (00 toolchain, 01-12 Book to a paper MES-ES limit-order book on IBKR via ibapi). Use when the user asks what lesson they are on, what to read next, or how a lesson maps to TWS, ibapi, MES, ES, or market depth. Open the matching lessons/NN-*/LESSON.md for the spec.
---

# 13-lesson curriculum

Source of truth for sequence: [lessons/README.md](../../../lessons/README.md).
Official language index: [Learn Rust](https://www.rust-lang.org/learn/).
Official broker index: [TWS API](https://interactivebrokers.github.io/tws-api/introduction.html).
Rust client: [`ibapi`](https://github.com/wboayue/rust-ibapi) (lesson 12 only).

## Intent

Take a beginner to a paper-traded MES → ES limit-order book on Interactive Brokers, fast, without replacing the Book.

Application destination: reconstruct Level 2 from TWS `reqMarketDepth` (insert / update / delete), route a limit, convert 10 MES ≡ 1 ES notional. Same types must also describe commodity micros (MCL, MGC).

## Bias

- Official tutorial over a homemade language syllabus.
- Student types the code. Agents quiz and review.
- Domain types appear early (tick, side, book, order) so lesson 12 is not a shock.
- No TWS, no `ibapi` crate, no order submit until lesson 12.
- Paper ports only (TWS 7497, Gateway 4002). Live ports are a failed lab.

## The arc

| Lessons | Theme | Wire |
| --- | --- | --- |
| 00 | rustfmt, clippy, test, backtrace, debugger | the PR toolchain |
| 01–04 | rustup through enums | TWS docs walk; ticks; book ownership; order state |
| 05–08 | crates, iterators, `Result`, traits | API a desk would actually review |
| 09–11 | tests, CLI, threads | replay a recorded book without TWS |
| 12 | paper `ibapi` | one MES paper limit; ES is size math, not a second live shot |

## Agent rules

When `@start-lesson N` runs:

1. Open `lessons/NN-*/LESSON.md`.
2. Confirm the student has done **Read first**.
3. Explain the one official concept. Ten to twenty lines, not the exercise.
4. Stop. The student creates the crate and writes the tests.
5. After they have a diff, `@review-rust`.

Do not implement `src/`.
Do not invent a thirteenth parallel syllabus.
Do not write an `ibapi` client, a book, or an order.

## Ports

| Account | TWS | Gateway |
| --- | --- | --- |
| Paper (allowed in 12) | 7497 | 4002 |
| Live (forbidden) | 7496 | 4001 |

## Rubric (every lesson)

Advance only if the student, not the model, can:

1. Name the Book chapter and the one concept.
2. Explain the last rustc error they hit.
3. Show green `cargo test` and clippy `-D warnings`.
4. Re-type the core function from a blank file.
5. Show no live port and no order submit before lesson 12 paper.
