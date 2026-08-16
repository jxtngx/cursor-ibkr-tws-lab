# Lesson 02 — Language foundations: ticks and multipliers

> Official spine: [Book ch. 3](https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html) · [Rust by Example — Primitives](https://doc.rust-lang.org/rust-by-example/primitives.html) · [RBE — Functions](https://doc.rust-lang.org/rust-by-example/fn.html)
> Companion: Rustlings variables, functions, if, primitive types
> Wire: CME contract specs. MES vs ES is a multiplier, not a different tick
> Domain hook: a 1-tick MES fill is $1.25; a 1-tick ES fill is $12.50. `f64` money is how you blow up a book

## Contract

No crates beyond `std`.
No order types yet (that is lesson 04).
The tutor may show a 15-line `fn add` example.
The tutor may not write `ticks_to_pnl`.

## Read first (do not skip)

- [ ] Book ch. 3 — variables, types, functions, comments, control flow
- [ ] RBE primitives + functions
- [ ] Rustlings through primitive types and if (stop before move semantics)
- [ ] Write down, from CME / IBKR contract specs *you* look up:
  - ES: multiplier, tick size, tick value
  - MES: multiplier, tick size, tick value
  - how many MES equal one ES in notional
  - one commodity pair the same way (CL / MCL or GC / MGC)

## Why this exists

IBKR will send prices as decimals.
Your *model* should be integer ticks plus a spec (tick size, multiplier).
If MES and ES are both "a `f64` price," you will size a 10-lot MES as if it were ES, or the reverse.
This lesson makes the numbers into functions you can test.

## You write

```bash
cd lessons/02-language-foundations
cargo init --lib --name lesson02
```

Public API (you choose names; tests must cover the behavior):

- A `Tick` as `i64` (signed so shorts work)
- A `FuturesSpec` of primitives: `symbol` can wait; for now `tick_size_e-N` or store tick size as rational (`numer/denom`) *or* store prices only as ticks and keep tick size in comments. Document the rule
- `fn mes_spec()` and `fn es_spec()` with the real multiplier and tick
- `fn tick_value_usd(spec, ticks: i64) -> i64` in **cents** (or a documented unit). 1 MES tick = 125 cents; 1 ES tick = 1250 cents
- `fn mes_lots_for_es_lots(es_lots: u32) -> u32` — 10 MES per 1 ES
- `fn es_lots_for_mes_lots(mes_lots: u32) -> Option<u32>` — `None` if not divisible by 10
- Reject overflow: multiplying lots × tick value must not silently wrap in library code (`checked_mul` → `Option` or a later `Result`)

Use functions and `if`.
Structs are allowed if you already peeked at ch. 5; they are not required.

## Plan of work

### A. Read

- [ ] Finish Book ch. 3 including the Fibonacci / temp conversion exercises *in your head or on paper*, then decide which ideas you need for tick math

### B. Tests first

- [ ] 1 MES tick → 125 cents
- [ ] 1 ES tick → 1250 cents
- [ ] 4 ticks MES (1.00 index point) → 500 cents
- [ ] 1 ES lot ≡ 10 MES lots
- [ ] 15 MES lots → `None` when converting to ES lots
- [ ] A `checked_mul` overflow path returns `None` / error, not a wrapped i64

### C. Implement until tests pass

- [ ] `cargo test`
- [ ] `cargo clippy --all-targets -- -D warnings`

### D. Recap (`NOTES.md`)

- [ ] Why prices are ticks, not `f64`
- [ ] The 10:1 MES→ES rule in one sentence
- [ ] One rustc error you hit and the actual cause
- [ ] CL/MCL or GC/MGC numbers you looked up (even if you did not code them)

## Definition of done

You can write `tick_value_usd` again from a blank file and defend cents vs dollars.
You have not used `unwrap` to silence a conversion.

## Stretch

Add `fn mcl_spec()` or `fn mgc_spec()` with tests.
Same functions, different constants.

## References

- https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html
- https://doc.rust-lang.org/rust-by-example/primitives.html
- CME / IBKR contract specs for ES, MES, and one commodity micro
- https://interactivebrokers.github.io/tws-api/basic_contracts.html
