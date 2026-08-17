# Lesson 06 — Collections and iterators: L2, microprice, imbalance

> Official spine: [Book ch. 8](https://doc.rust-lang.org/book/ch08-00-common-collections.html) · [Book ch. 13](https://doc.rust-lang.org/book/ch13-00-functional-features.html)
> Companion: Rustlings vecs, hashmaps, iterators; [RBE — Iterators](https://doc.rust-lang.org/rust-by-example/trait/iter.html)
> Wire (reading): [TWS market depth](https://interactivebrokers.github.io/tws-api/market_depth.html) — op 0 insert, 1 update, 2 delete; side 0 bid, 1 ask
> Domain hook: quoting needs microprice and imbalance, not just best bid/ask

## Contract

`std` only.
The tutor may not write `apply` or `microprice`.
Honor TWS *position* for insert/update/delete. Document `Vec` vs `BTreeMap`.

## Read first (do not skip)

- [ ] Book ch. 8 — `Vec`, `String`, `HashMap` (look up `BTreeMap`)
- [ ] Book ch. 13 — closures, iterators
- [ ] TWS market depth in full. Write the three operations in comments first
- [ ] Look up *microprice* (size-weighted mid) and *book imbalance*. Write the formulas you will implement before coding

## Why this exists

TWS sends incremental row edits.
If insert/delete shift is wrong, the inside is a ghost.
Inventory-aware quoting (lesson 08) will lean on:

```text
microprice ≈ (ask * bid_size + bid * ask_size) / (bid_size + ask_size)
imbalance  = (bid_size - ask_size) / (bid_size + ask_size)
```

(top of book, or top-N — document which.)

## You write

```text
fn apply(&mut self, upd: DepthUpdate) -> Result<(), BookError>
fn microprice_ticks(&self) -> Option<i64>   // nearest tick; document rounding
fn imbalance(&self) -> Option<f64>          // [-1, 1], or a rational you document
```

Required apply behavior:

1. op 0 insert at `position`
2. op 1 update at `position`
3. op 2 delete at `position`
4. side 0 bid, 1 ask
5. out-of-range → `Err`, not panic
6. `best_bid`, `best_ask`, `spread_ticks`

Use iterators for size sums.
Tests from a hand-built tape. No socket.

## Plan of work

### A. Read

- [ ] Two Book ch. 8 exercises, then stop
- [ ] Insert/update/delete rules in comments
- [ ] Microprice + imbalance formulas in comments

### B. Tests

- [ ] Insert three bids; row 0 is the inside (document that)
- [ ] Update size at 0
- [ ] Delete 0; old 1 becomes inside
- [ ] Insert at 0 pushes the old inside down
- [ ] Ask independent of bid
- [ ] Symmetric book → imbalance 0, microprice = mid
- [ ] Heavy bid size → imbalance > 0 and microprice closer to the ask (or the opposite, if you used the other convention — **document and test the one you chose**)

### C. Notes

- [ ] Odd lots excluded by TWS — what that means for tests
- [ ] Why quoting should use microprice, not last trade, on a quiet MES book

## Definition of done

A 10-line fixture replays twice with the same inside, microprice, and imbalance.

## Stretch

Top-N imbalance (N = 3) vs top-1. Test they differ on a skewed book.

## References

- https://doc.rust-lang.org/book/ch08-00-common-collections.html
- https://doc.rust-lang.org/book/ch13-00-functional-features.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
