# Lesson 04 — Structs and enums: contracts, sides, orders

> Official spine: [Book ch. 5](https://doc.rust-lang.org/book/ch05-00-structs.html) · [Book ch. 6](https://doc.rust-lang.org/book/ch06-00-enums.html)
> Companion: Rustlings structs, enums; [RBE — Enums](https://doc.rust-lang.org/rust-by-example/custom_types/enum.html)
> Wire: [TWS contracts](https://interactivebrokers.github.io/tws-api/basic_contracts.html) · [TWS orders](https://interactivebrokers.github.io/tws-api/basic_orders.html)
> Domain hook: MES and ES are two `FuturesSpec`s, not two codepaths. A limit is `OrderType::Limit { ticks }`, not a boolean soup

## Contract

One crate, `std` only.
The tutor may show `enum IpAddr`.
The tutor may not write `OrderStatus` or `FuturesSpec`.

## Read first (do not skip)

- [ ] Book ch. 5 — structs, methods, associated functions
- [ ] Book ch. 6 — enums, `match`, `if let`, `Option`
- [ ] Rustlings structs + enums
- [ ] TWS basic contracts (FUT, local symbol vs symbol, expiry / front month)
- [ ] TWS basic orders (MKT, LMT, TIF DAY / GTC)

## Why this exists

A contribution-quality trading crate will be rejected if "the order" is a pile of `bool`s.
You need a side, a TIF, an order type, and a status machine that cannot be `Filled` after `Cancelled` without going through a transition you wrote.

## You write

```bash
cd lessons/04-structs-enums
cargo init --lib --name lesson04
```

Types (names yours; behavior not):

- `Side { Bid, Ask }` (or Buy/Sell — pick one and map to TWS 0/1 in rustdoc)
- `Tif { Day, Gtc }` — only what you will use
- `OrderType { Market, Limit { ticks: i64 } }`
- `OrderStatus { New, Submitted, Partial { filled: u32 }, Filled, Cancelled, Rejected }`
- `fn OrderStatus::on_fill(self, fill_qty: u32, order_qty: u32) -> Self`
- `fn OrderStatus::on_cancel(self) -> Self` — cannot resurrect a `Filled`
- `FuturesSpec { symbol, multiplier, tick_size_ticks or documented ticks }` with `mes()`, `es()`, and one commodity micro
- `ContractKey { symbol, expiry: Option<...>` } — expiry can be a `String` YYYYMM this week; do not call IBKR
- `Order { id, contract, side, qty, typ, tif, status }`

`match` must be exhaustive.
No `unwrap` on quantities in library paths.
A `Limit` with negative ticks is not a panic — `Option` / reject.

## Plan of work

### A. Read

- [ ] Implement the Book ch. 5 rectangle example yourself before `FuturesSpec`
- [ ] Write a `match` on `OrderStatus` without `unwrap`

### B. Tests

- [ ] `mes().multiplier * 10 == es().multiplier` (or the equivalent in your units)
- [ ] Partial fill then fill
- [ ] Cancel from `Submitted` works; cancel from `Filled` is a no-op or `Err` you document
- [ ] `OrderType::Limit { ticks: -1 }` cannot be built, or is rejected

### C. Domain note (`NOTES.md`)

- [ ] One paragraph: why MES and ES share `Order` and differ only by `FuturesSpec`
- [ ] One paragraph: why commodity micros fit the same types
- [ ] TWS side 0 = bid, 1 = ask — how your `Side` maps

## Definition of done

You can draw the `OrderStatus` diagram from memory.
A reviewer can read `FuturesSpec` and know MES is not a special case.

## Stretch

Add `OrderType::Stop { ticks }` *only if* you write the status rule.
Do not add unused variants "for later."

## References

- https://doc.rust-lang.org/book/ch05-00-structs.html
- https://doc.rust-lang.org/book/ch06-00-enums.html
- https://interactivebrokers.github.io/tws-api/basic_contracts.html
- https://interactivebrokers.github.io/tws-api/basic_orders.html
