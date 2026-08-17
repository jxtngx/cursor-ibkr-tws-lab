# Lesson 08 — Traits and lifetimes: feed, router, inventory quoter

> Official spine: [Book ch. 10](https://doc.rust-lang.org/book/ch10-00-generics.html)
> Companion: Rustlings generics, traits, lifetimes; [RBE — Traits](https://doc.rust-lang.org/rust-by-example/trait.html)
> Domain hook: a JSONL replay and a later IB feed must drive the same `OrderBook` and the same inventory-aware quoter
> Wire: no socket. A later adapter implements `MarketData` / `OrderRouter`

## Contract

The tutor may show `fn notify(item: &impl Summary)`.
The tutor may not write `trait Quoter`.
No `ibapi`.

## Read first (do not skip)

- [ ] Book ch. 10 — generics, traits, bounds, lifetimes
- [ ] Rustlings traits + lifetimes
- [ ] Your `Inventory`, `microprice_ticks`, `imbalance`
- [ ] Skim TWS orders page (names only)

## Why this exists

If the book is glued to a socket, you cannot test a quote on a plane.
Market-making here is **inventory-aware quoting**, not a strategy dump:

- Want to sit near microprice
- If long, shade down / bid less aggressively
- If short, shade up
- If `|inventory|` hits a max, quote only the flattening side (or pull)

You write the rule. Tests lock it.

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

trait Quoter {
    fn quote(&self, book: &OrderBook, inv: &Inventory) -> Quote;
}

struct Quote {
    bid: Option<Limit>, // ticks + size, or None = pull
    ask: Option<Limit>,
}
```

Impls (in-process):

- `JsonlFeed` / `ScriptedFeed`
- `PaperRouter` — rest or fill against the current book (your matcher, not IBKR)
- `RejectLiveRouter` — always `Err` paper-only
- `InventoryQuoter` — your documented shade rule + `max_abs_lots`

`next_update` returns an owned `DepthUpdate`.

## Plan of work

### A. Read

- [ ] Book ch. 10 `Summary` example yourself
- [ ] One explicit `'a` and one elided

### B. Implement

- [ ] Traits + impls
- [ ] Flat inventory + symmetric book → two-sided quote around microprice (document offset in ticks)
- [ ] Long inventory → bid pulled or lowered vs the flat case
- [ ] `|inv| == max` → flattening side only
- [ ] `RejectLiveRouter` never records a fill

### C. Notes

- [ ] Why `Quoter` takes `&OrderBook` and `&Inventory`, not a global
- [ ] Why a later `ibapi` client is an `OrderRouter`, not a `Quoter`

## Definition of done

Swapping `ScriptedFeed` for `JsonlFeed` does not touch `InventoryQuoter`.
No `'static` escape hatches.
No `ibapi` in `Cargo.toml`.

## References

- https://doc.rust-lang.org/book/ch10-00-generics.html
- https://interactivebrokers.github.io/tws-api/basic_orders.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
