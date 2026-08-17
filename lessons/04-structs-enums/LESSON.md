# Lesson 04 — Structs and enums: contracts, sides, inventory

> Official spine: [Book ch. 5](https://doc.rust-lang.org/book/ch05-00-structs.html) · [Book ch. 6](https://doc.rust-lang.org/book/ch06-00-enums.html)
> Companion: Rustlings structs, enums; [RBE — Enums](https://doc.rust-lang.org/rust-by-example/custom_types/enum.html)
> Wire (reading): [TWS contracts](https://interactivebrokers.github.io/tws-api/basic_contracts.html) · [TWS orders](https://interactivebrokers.github.io/tws-api/basic_orders.html)
> Domain hook: MES first. ES is another `FuturesSpec`. Inventory is a signed lot count, not a boolean

## Contract

One crate, `std` only.
The tutor may show `enum IpAddr`.
The tutor may not write `OrderStatus` or `Inventory`.

## Read first (do not skip)

- [ ] Book ch. 5 — structs, methods, associated functions
- [ ] Book ch. 6 — enums, `match`, `if let`, `Option`
- [ ] Rustlings structs + enums
- [ ] TWS basic contracts (FUT) and orders (MKT, LMT, DAY / GTC)

## Why this exists

Inventory-aware quoting (lesson 08) needs a type that cannot be "long and short at once."
MES and ES share `Order` and differ by `FuturesSpec`.
A limit is `OrderType::Limit { ticks }`, not a pile of `bool`s.

## You write

```bash
cd lessons/04-structs-enums
cargo init --lib --name lesson04
```

- `Side { Bid, Ask }` — rustdoc maps to TWS 0/1
- `Tif { Day, Gtc }`
- `OrderType { Market, Limit { ticks: i64 } }`
- `OrderStatus { New, Submitted, Partial { filled: u32 }, Filled, Cancelled, Rejected }`
- `fn OrderStatus::on_fill(self, fill_qty: u32, order_qty: u32) -> Self`
- `fn OrderStatus::on_cancel(self) -> Self` — cannot resurrect `Filled`
- `FuturesSpec` with `mes()` first, then `es()`, optional one commodity micro
- `Inventory { lots: i32 }` — positive long, negative short
- `fn Inventory::on_fill(&mut self, side: Side, qty: u32)` — buy increases, sell decreases
- `fn Inventory::is_flat(&self) -> bool`
- `Order { id, spec, side, qty, typ, tif, status }`

`match` exhaustive.
Negative limit ticks rejected.
No `unwrap` on qty in library paths.

## Plan of work

### A. Read

- [ ] Book ch. 5 rectangle yourself before `FuturesSpec`
- [ ] `match` on `OrderStatus` without `unwrap`

### B. Tests

- [ ] `mes().multiplier * 10 == es().multiplier` (in your units)
- [ ] Partial then fill
- [ ] Cancel from `Submitted`; cancel from `Filled` is `Err` or no-op you document
- [ ] Buy 2 MES → inventory +2; sell 2 → flat
- [ ] `Limit { ticks: -1 }` rejected

### C. Notes

- [ ] Why MES and ES share `Order`
- [ ] Why a commodity micro fits the same types
- [ ] Why `Inventory` is signed lots, not two counters

## Definition of done

You can draw `OrderStatus` from memory.
You can explain why quoting will take `&Inventory`, not a global.

## References

- https://doc.rust-lang.org/book/ch05-00-structs.html
- https://doc.rust-lang.org/book/ch06-00-enums.html
- https://interactivebrokers.github.io/tws-api/basic_contracts.html
- https://interactivebrokers.github.io/tws-api/basic_orders.html
