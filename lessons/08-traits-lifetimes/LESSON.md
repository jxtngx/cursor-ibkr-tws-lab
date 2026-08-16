# Lesson 08 — Traits and lifetimes: MarketData and OrderRouter

> Official spine: [Book ch. 10](https://doc.rust-lang.org/book/ch10-00-generics.html)
> Companion: Rustlings generics, traits, lifetimes; [RBE — Traits](https://doc.rust-lang.org/rust-by-example/trait.html)
> Wire: this is the API lesson 12's `ibapi` adapter will implement. Stubs now. No socket
> Domain hook: a JSONL replay and a live paper feed must drive the *same* book and router

## Contract

The tutor may show `fn notify(item: &impl Summary)`.
The tutor may not write `trait MarketData`.
Real `ibapi` is lesson 12.

## Read first (do not skip)

- [ ] Book ch. 10 — generics, traits, trait bounds, lifetimes
- [ ] Rustlings traits + lifetimes
- [ ] Skim `ibapi` `Client` methods for market data / orders (names only)
- [ ] Re-read TWS market depth + basic orders pages

## Why this exists

If the book is glued to a socket, you cannot test it on a plane.
A paper `ibapi` client and a JSONL feeder should be two impls of one trait.
Lifetimes show up when an update *borrows* a buffer. Prefer owned `DepthUpdate` in the public trait unless you can name the source.

## You write

```text
trait MarketData {
    fn name(&self) -> &'static str;
    fn next_update(&mut self) -> Result<Option<DepthUpdate>>;
}

trait OrderRouter {
    fn submit(&mut self, order: NewOrder) -> Result<OrderId>;
    fn cancel(&mut self, id: OrderId) -> Result<()>;
}
```

Impls (all in-process):

- `JsonlFeed` — reads the lesson 07 fixture
- `ScriptedFeed` — `Vec<DepthUpdate>` you push in tests
- `PaperRouter` — records submitted orders, fills against the *current* book if a limit is marketable, otherwise rests. This is *your* matching, not IBKR's
- `RejectLiveRouter` — every submit returns `WireError::paper-only` (use this if someone passes a live flag)

Lifetime rule:

- `next_update` returns an owned `DepthUpdate`
- Do not return references into the feed's buffer unless `'a` is on the trait and you can defend it

A generic `fn run_once<F: MarketData, R: OrderRouter>(book, feed, router, maybe_order)` used by tests.

## Plan of work

### A. Read

- [ ] Write the Book ch. 10 `NewsArticle` / `Summary` example yourself
- [ ] Write one function that needs an explicit `'a` and one that should use elision

### B. Implement

- [ ] Traits + impls
- [ ] Test: scripted feed rebuilds a known book
- [ ] Test: resting bid does not fill when ask is above
- [ ] Test: marketable limit fills in `PaperRouter`
- [ ] Test: `RejectLiveRouter` never records a fill

### C. Notes

- [ ] Would `ibapi` implement `MarketData` on `Client` or on a subscription wrapper? Five sentences
- [ ] Why `Book` is *not* a trait object this week

## Definition of done

Swapping `ScriptedFeed` for `JsonlFeed` is a type-parameter change, not a rewrite.
No `'static` escape hatches on updates.
No `ibapi` in `Cargo.toml`.

## Stretch

Sketch `struct IbapiFeed { ... }` field list only. No connect.

## References

- https://doc.rust-lang.org/book/ch10-00-generics.html
- https://docs.rs/ibapi/
- https://interactivebrokers.github.io/tws-api/market_depth.html
- https://interactivebrokers.github.io/tws-api/basic_orders.html
