# Lesson 03 — Ownership: the book owns the levels

> Official spine: [Book ch. 4](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
> Companion: Rustlings move semantics; [RBE — Ownership](https://doc.rust-lang.org/rust-by-example/scope/move.html)
> Wire: TWS `updateMktDepth` is a *borrowed event*. The book is the owner. `ibapi` subscriptions will later stream those events
> Domain hook: cloning the whole book on every depth update is a failed lesson

## Contract

The tutor explains move vs borrow vs `&mut`.
The tutor does not write your `Book` type.
No `clone()` unless a test proves the levels must outlive the source.

## Read first (do not skip)

- [ ] Book ch. 4 in full (ownership, references, slices)
- [ ] Rustlings move-semantics exercises
- [ ] [TWS market depth](https://interactivebrokers.github.io/tws-api/market_depth.html) — operation 0/1/2, side 0/1, position index. You will implement apply in lesson 06; this week you only need the *ownership* story

## Why this exists

A depth callback is small: side, position, operation, price, size.
The book is large: two sides of N levels.
`ibapi` will later hand you a subscription item that must not own the book, and the book must not own the socket.
If you do not have a model for "who owns the levels," you will clone the book to please rustc or fight the borrow checker in lesson 11.

## You write

```bash
cd lessons/03-ownership
cargo init --lib --name lesson03
```

Model a tiny book in `std` only (fixed depth is fine, e.g. 5 levels per side):

- `Level { price_ticks: i64, size: u32 }`
- `Book` owns `bids: Vec<Level>` and `asks: Vec<Level>` (or arrays)
- `DepthUpdate` is a value: `side`, `position`, `op`, `price_ticks`, `size`
- `fn apply(&mut self, upd: &DepthUpdate)` — this week a stub that only **updates** an existing position if it is in range (insert/delete can `todo!` or return `false`). The point is `&mut Book` + `&DepthUpdate`
- `fn best_bid(&self) -> Option<&Level>` / `fn best_ask(&self) -> Option<&Level>`
- `fn mid_ticks(&self) -> Option<i64>` if both sides exist
- Tests that prove:
  - two shared borrows of `best_bid` / `best_ask` can coexist
  - `apply` cannot run while those borrows are live (compile-fail thought experiment — write it in `NOTES.md` if you cannot encode it as a test)
  - moving `Book` invalidates the old name

Reuse lesson 02 tick functions only if you copy *your* code by hand.

## Plan of work

### A. Read Book 4 until you can answer

- [ ] What is moved when you pass `Book` by value?
- [ ] Why `&DepthUpdate` vs owned update is the same question as `&str` vs `String`?

### B. Implement

- [ ] `Level` / `Book` / `DepthUpdate` / `apply` (update-only)
- [ ] Tests for best bid/ask and out-of-range position

### C. Upstream comparison (`NOTES.md`)

- [ ] Three bullets: who owns the book vs the TWS callback
- [ ] Why `clone()` on `Book` inside `apply` would be a lie
- [ ] One rustc error you fixed by changing the *model*, not by cloning

## Definition of done

You can explain, at a whiteboard, who owns the book in a feed → book → router loop.
`cargo test` is green with no `clone` on the happy path of `apply`.

## Stretch

Read how `ibapi` names a market-data subscription (iterator / stream).
Write whether the item is owned. Say what *your* `apply` should take.

## References

- https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
- https://docs.rs/ibapi/
