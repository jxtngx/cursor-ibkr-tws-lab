# Lesson 03 — Ownership: the book owns the levels

> Official spine: [Book ch. 4](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
> Companion: Rustlings move semantics; [RBE — Ownership](https://doc.rust-lang.org/rust-by-example/scope/move.html)
> Wire (later): TWS `updateMktDepth` is a borrowed event. `OrderBook` is the owner
> Domain hook: cloning the whole book on every depth update is a failed lesson

## Contract

The tutor explains move vs borrow vs `&mut`.
The tutor does not write your `OrderBook`.
No `clone()` unless a test proves the levels must outlive the source.

## Read first (do not skip)

- [ ] Book ch. 4 in full (ownership, references, slices)
- [ ] Rustlings move-semantics exercises
- [ ] [TWS market depth](https://interactivebrokers.github.io/tws-api/market_depth.html) — operation 0/1/2, side 0/1, position. Apply is lesson 06; this week is ownership

## Why this exists

A depth callback is small: side, position, operation, price, size.
The book is large: two sides of N `DOMLevel`s.
A later `ibapi` subscription must not own the book, and the book must not own a socket.
If you clone the book to please rustc, lesson 11 will be theater.

## You write

```bash
cd lessons/03-ownership
cargo init --lib --name lesson03
```

`std` only. Fixed depth is fine (e.g. 5 levels per side):

- `DOMLevel { price_ticks: i64, size: u32 }`
- `OrderBook` owns `bids: Vec<DOMLevel>` and `asks: Vec<DOMLevel>`
- `DepthUpdate` is a value: `side`, `position`, `op`, `price_ticks`, `size`
- `fn apply(&mut self, upd: &DepthUpdate)` — this week **update-only** if the position is in range (insert/delete can return `false`). Point is `&mut OrderBook` + `&DepthUpdate`
- `fn best_bid(&self) -> Option<&DOMLevel>` / `fn best_ask(&self) -> Option<&DOMLevel>`
- Tests:
  - two shared borrows of best bid/ask can coexist
  - `apply` cannot run while those borrows are live (write the compile-fail in `NOTES.md` if needed)
  - moving `OrderBook` invalidates the old name

Copy lesson 02 tick helpers by hand if you need them.

## Plan of work

### A. Read Book 4 until you can answer

- [ ] What is moved when you pass `OrderBook` by value?
- [ ] Why `&DepthUpdate` vs owned update is `&str` vs `String`?

### B. Implement

- [ ] `DOMLevel` / `OrderBook` / `DepthUpdate` / update-only `apply`
- [ ] Tests for best bid/ask and out-of-range position

### C. Notes

- [ ] Who owns the book vs a later TWS callback
- [ ] Why `clone()` on `OrderBook` inside `apply` is a lie
- [ ] One rustc error you fixed by changing the model, not by cloning

## Definition of done

You can explain who owns the book in feed → book → quoter.
`cargo test` green, no `clone` on the happy path of `apply`.

## References

- https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
