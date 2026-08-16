# Lesson 12 — Paper TWS: MES → ES on a real book

> Official spine: [Book ch. 20](https://doc.rust-lang.org/book/ch20-00-advanced-features.html) as needed · [Nomicon ch. 1–3](https://doc.rust-lang.org/nomicon/) if you touch `unsafe` · [TWS API](https://interactivebrokers.github.io/tws-api/introduction.html) · [`ibapi`](https://docs.rs/ibapi/)
> Companion: [TWS market depth](https://interactivebrokers.github.io/tws-api/market_depth.html) · [contracts](https://interactivebrokers.github.io/tws-api/basic_contracts.html) · [orders](https://interactivebrokers.github.io/tws-api/basic_orders.html) · [ib-interface](https://github.com/jxtngx/ib-interface) as a Python *reference* only
> Destination: a paper MES limit sitting on *your* reconstructed book, with ES treated as 10× MES notional. Optional: a small example PR to `wboayue/rust-ibapi` if you find a real gap

## Contract

This is the only lesson that may add `ibapi` and open a socket.
**Paper ports only: TWS 7497 or Gateway 4002.**
Live 7496 / 4001 are a failed lab.
The tutor may map `ibapi` types to your traits.
The tutor may not write the adapter, pick your limit price, or submit an order.

One paper order is enough.
MES first.
ES is size math and a *second depth subscription*, not a second live shot this week.

## Read first (do not skip)

- [ ] Book ch. 20 — `unsafe` / FFI only if you need it. Prefer staying safe
- [ ] Nomicon 1–3 if any `unsafe` appears
- [ ] TWS API: enable the API, paper login, client id, market-depth permission
- [ ] `ibapi` README: `Client::connect`, `Contract::futures`, subscribe, `order().buy().limit().submit()`
- [ ] Your lessons 06–11 code. If the book does not replay, stop. Do not debug TWS and a broken `apply` at once

## Why this exists

Lessons 00–11 exist so this session is boring in the right ways: ticks, ownership, `Result`, a small trait, a paper-port guard.
The destination stack is:

```text
IB Gateway / TWS paper (4002 / 7497)
  → ibapi Client
  → DepthUpdate (your type)
  → Book::apply (your type)
  → OrderRouter (your trait, ibapi impl)
  → one MES limit on the inside or one tick behind
  → ES lots = mes_lots / 10 when you *print* the equivalent, not when you submit
```

`ibapi` already speaks TWS.
Your job is the adapter and the discipline: paper, MES, one order, tests still green offline.

## You write

In a crate `wire` (or `ibkr`) that depends on `tick`, `book`, `order`, and now `ibapi`:

1. `fn connect_paper(host, port, client_id) -> Result<Client>` that **rejects** live ports via lesson 07 `parse_port`
2. `Contract::futures("MES")` front month (or the `ibapi` builder equivalent you read). Resolve/qualify as the crate requires
3. Subscribe market depth for MES. Map each TWS-shaped event to `DepthUpdate`. Apply to *your* `Book`
4. Subscribe ES depth into a *second* `Book` (same types). Do not trade it
5. Print both ladders and the 10:1 notional line (`tick_value_usd`)
6. Submit **one** paper MES limit: quantity 1, on your side of the book, not marketable if you can avoid it (join, do not cross, unless you document a one-tick cross)
7. Wait for status (`Submitted` / rest / fill / reject). Cancel if it still rests after a timeout you chose
8. Default `cargo test` does **not** hit the network (`#[ignore]` or feature `paper-tws`)

`lob --paper --port 4002 --symbol MES` may grow here.
`--port 7496` must still fail before connect.

## Plan of work

### A. Declare

- [ ] `lessons/12-paper-tws/PATH.md`: paper port, client id *range* (not your account number), async vs sync `ibapi` feature
- [ ] Confirm TWS/Gateway paper is logged in and API enabled

### B. Offline first

- [ ] Adapter maps a *recorded* TWS-like event (you may hand-write one) onto `DepthUpdate` without a socket
- [ ] `parse_port(7496)` still `Err`

### C. Paper socket

- [ ] Connect 4002 or 7497
- [ ] MES depth prints at least one bid and one ask
- [ ] ES depth prints (subscription only)
- [ ] One MES limit, then cancel or fill
- [ ] `NOTES.md` has the order id and final status — no account number

### D. Unsafe budget

- [ ] Every `unsafe` block has `// SAFETY:` or you added none
- [ ] No `unsafe` to silence the borrow checker

### E. Optional upstream

- [ ] If `ibapi` is missing a futures-depth example, a draft PR or issue on `wboayue/rust-ibapi` with a *minimal* snippet you wrote
- [ ] Do not paste an agent-generated client as the PR

## Definition of done

- [ ] Offline tests still pass without TWS
- [ ] Paper connect works on 7497 or 4002
- [ ] Live ports refused
- [ ] One MES paper order lifecycle you can narrate
- [ ] ES book printed; no ES order
- [ ] You can explain every line of the adapter

## What this lesson is not

- A live account
- An ES order
- A strategy dump (spread, arb, scalper) written by an agent
- A port of [ib-interface](https://github.com/jxtngx/ib-interface)
- Training or backtests
- Financial advice

## References

- https://interactivebrokers.github.io/tws-api/introduction.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
- https://interactivebrokers.github.io/tws-api/basic_contracts.html
- https://interactivebrokers.github.io/tws-api/basic_orders.html
- https://github.com/wboayue/rust-ibapi
- https://docs.rs/ibapi/
- https://github.com/jxtngx/ib-interface
- https://doc.rust-lang.org/book/ch20-00-advanced-features.html
- https://doc.rust-lang.org/nomicon/
