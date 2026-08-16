# Lesson 06 — Collections and iterators: reconstruct the book

> Official spine: [Book ch. 8](https://doc.rust-lang.org/book/ch08-00-common-collections.html) · [Book ch. 13](https://doc.rust-lang.org/book/ch13-00-functional-features.html)
> Companion: Rustlings vecs, hashmaps, iterators; [RBE — Iterators](https://doc.rust-lang.org/rust-by-example/trait/iter.html)
> Wire: [TWS market depth](https://interactivebrokers.github.io/tws-api/market_depth.html) — operation 0 insert, 1 update, 2 delete; side 0 bid, 1 ask; `position` is the row index
> Domain hook: this is the algorithm `reqMarketDepth` expects you to run. No TWS required

## Contract

`std` only. `BTreeMap` / `Vec` are the point.
The tutor may not write `apply`.
A `BTreeMap<i64, u32>` per side (price ticks → size) is acceptable if you also honor *position* for TWS-shaped updates. Document which representation you chose and why.

## Read first (do not skip)

- [ ] Book ch. 8 — `Vec`, `String`, `HashMap` (and look up `BTreeMap`)
- [ ] Book ch. 13 — closures, iterators, adapters
- [ ] TWS market depth page in full. Write the three operations in comments *before* code

## Why this exists

You do not need a broker to learn a book.
TWS sends incremental row edits, not a full snapshot every time (after the initial rows).
If insert/delete shift is wrong, your best bid is a ghost and a MES limit sits on a level that does not exist.

## You write

In the workspace from lesson 05 (or `lessons/06-collections-iterators`):

```text
fn apply(&mut self, upd: DepthUpdate) -> Result<(), BookError>
```

Required behavior (TWS-shaped):

1. `operation = 0` insert at `position` (existing rows at that index and below shift away from the touch, or follow the TWS rule you documented)
2. `operation = 1` update price/size at `position`
3. `operation = 2` delete at `position` (later rows shift toward the touch)
4. Side 0 = bid, 1 = ask (or your `Side`)
5. Out-of-range position is `Err`, not a panic
6. After applies: `best_bid`, `best_ask`, `spread_ticks`, `bid_size_at(ticks)`, `imbalance` (top-N size bid−ask) / (bid+ask)

Use iterators for sums and filters.
Tests from a hand-built tape. No socket.

## Plan of work

### A. Read

- [ ] Implement two Book ch. 8 exercises yourself, then stop
- [ ] Write the insert/update/delete shifting rules in comments

### B. Tests (table-driven)

- [ ] Insert three bid levels, best bid is the highest price (or the row-0 bid — **document TWS row 0 = inside**)
- [ ] Update size at position 0
- [ ] Delete position 0, the old position 1 becomes best
- [ ] Insert at position 0 pushes the old inside down
- [ ] Ask side independent of bid
- [ ] Spread and imbalance on a known book

### C. Notes

- [ ] TWS: "we cannot guarantee every price quoted will be displayed"; odd lots excluded. What that means for your tests
- [ ] Smart depth (`isSmartDepth`) — one sentence, you will not implement exchange MPIDs this week

## Definition of done

You can apply a 10-line fixture and get the same best bid/ask twice.
`cargo test` covers insert, update, delete, and an out-of-range error.

## Stretch

Store a `BTreeMap` *and* a `Vec` of positions and keep them in sync — or argue in `NOTES.md` why one is enough.

## References

- https://doc.rust-lang.org/book/ch08-00-common-collections.html
- https://doc.rust-lang.org/book/ch13-00-functional-features.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
