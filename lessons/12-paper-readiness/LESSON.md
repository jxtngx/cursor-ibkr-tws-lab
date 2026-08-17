# Lesson 12 — Paper readiness: sessions, force-flat, protobuf sketch

> Official spine: [Book ch. 20](https://doc.rust-lang.org/book/ch20-00-advanced-features.html) only if you need advanced traits / `unsafe` — prefer staying in safe Rust · [TWS API intro](https://interactivebrokers.github.io/tws-api/introduction.html) as *reading*
> Companion: CME / CME Globex session notes you look up · [`ibapi`](https://docs.rs/ibapi/) README · protobuf / prost *docs* (do not add the crate)
> Destination: the crate is **ready to wire**. It is not wired

## Contract

No `ibapi`. No `prost`. No socket. No order submit.
The tutor may name a TWS message or a session clock.
The tutor may not write `SessionClock`, `ForceFlat`, or a protobuf decoder.

This is the last lesson.
You finish the risk gates that a paper (and later live) desk would refuse to skip.

## Read first (do not skip)

- [ ] Your `risk` crate from lesson 05, `Inventory`, `Quoter`, velocity filter
- [ ] Look up MES/ES **session** times (CME Globex). Write the two windows this lab uses:
  - **pre-market** (you define the clock in tests with a fake `now`)
  - **lunch** (you define)
- [ ] TWS API intro + `ibapi` README enough to list: connect, market depth, order submit — as *future* adapter methods, not code
- [ ] How IBKR encodes newer messages with protobuf (ib-interface / TWS notes). You will sketch types, not generate them

## Why this exists

A quoter that is always on will quote the overnight gap and the lunch dead zone.
Outside allowed windows you **force-flat**: pull both quotes; if `Inventory` is not zero, emit a flatten *intent* (a `NewOrder` you do **not** send).
Paper readiness is those gates plus a written map from *your* types to a later protobuf / `ibapi` adapter.

```text
SessionClock::allowed(now) == false
  → Quoter silent
  → ForceFlat::intent(inventory) → Option<NewOrder>
  → OrderRouter is *not* called in this lab
```

## You write

In `risk/` (or `lessons/12-paper-readiness`):

```text
struct SessionWindow { start: Time, end: Time } // naive time-of-day is enough
struct SessionClock { pre_market: SessionWindow, lunch: SessionWindow }

fn SessionClock::allowed(&self, now: Time) -> bool
  // true only inside pre-market OR lunch (this lab's rule; document it)

fn too_fast(...) // already in 11; call it from here or re-export

enum RiskDecision { Quote(Quote), Pull, Flatten(NewOrder) }

fn decide(clock, now, book, inv, quoter, last_quote_at) -> RiskDecision
```

Rules:

- Fake `now` in tests. Do not read the OS clock for assertions
- Outside windows → `Pull` if flat, `Flatten` if not
- Inside windows → `Quote` unless velocity says wait (`Pull` / hold)
- Flatten intent uses `FuturesSpec::mes()` first. ES flatten is a *test* that 10 MES ≡ 1 ES lots convert; you do not emit an ES order
- `parse_port(7496)` still `Err`

Also write `NOTES.md`:

- Table: your type → later wire (`DOMLevel` → `updateMktDepth` fields, `NewOrder` → `ibapi` limit, `DepthUpdate` → protobuf market-depth message). Paths and field names you *read*, not invented
- Three sentences: where `wire/` would live, why it depends on `book` and not the reverse, async vs sync `ibapi` you would pick
- Explicit: you did not add `ibapi` or connect

Optional stretch (still no crate dep): a `enum WireMsg { Depth { .. }, OrderAck { .. } }` that *looks like* a decoded protobuf enum, plus a test that a hand-built byte slice you defined maps to one variant. Do not add `prost`.

## Plan of work

### A. Session

- [ ] `allowed` true in pre-market fixture, true in lunch fixture, false otherwise
- [ ] Overnight / regular-hours fixture (whatever you did *not* allow) is false

### B. Force-flat

- [ ] Flat + closed session → `Pull`, no flatten order
- [ ] Long 2 MES + closed session → `Flatten` sell 2 MES
- [ ] Open session + long 2 → still a two-sided or shaded `Quote`, not a flatten

### C. Gates together

- [ ] Open session + too-fast → no new quote (hold / `Pull`)
- [ ] Closed session bypasses velocity and still flattens
- [ ] Live port constant cannot sneak into `decide`

### D. Sketch, do not wire

- [ ] `NOTES.md` adapter table
- [ ] `cargo test --workspace` green with no network

## Definition of done

You can explain, without a broker, when this crate quotes, when it pulls, and when it would flatten.
MES is the only flatten spec.
`Cargo.toml` has no `ibapi`, no `prost`.
You can write `decide` again from a blank file.

## What this lesson is not

- A TWS connection
- A paper or live order
- An ES order
- A generated protobuf stack
- A port of [ib-interface](https://github.com/jxtngx/ib-interface)
- Financial advice

## After the lab

Take *your* crate, add `ibapi` or prost in a different project, connect to paper 4002 / 7497, and implement `MarketData` + `OrderRouter`.
That work is not a lesson here.

## References

- https://interactivebrokers.github.io/tws-api/introduction.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
- https://docs.rs/ibapi/
- https://github.com/wboayue/rust-ibapi
- https://github.com/jxtngx/ib-interface
- https://docs.rs/prost/
- https://doc.rust-lang.org/book/ch20-00-advanced-features.html
