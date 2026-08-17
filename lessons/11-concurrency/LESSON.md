# Lesson 11 — Concurrency: feed, book, quoter, velocity

> Official spine: [Book ch. 15](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html) · [Book ch. 16](https://doc.rust-lang.org/book/ch16-00-concurrency.html) · optional [Book ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html)
> Companion: [RBE — Threads](https://doc.rust-lang.org/rust-by-example/std_misc/threads.html)
> Domain hook: a burst of depth updates must not produce a burst of quote replaces. That is the "too-fast" / velocity filter
> Wire: `ibapi` v3 default is async. You do not add it. Threads first; async is stretch

## Contract

Threads + channels first.
The tutor may show `mpsc::channel`.
The tutor may not write the pipeline or the filter.
No `unsafe`. No `ibapi`.

## Read first (do not skip)

- [ ] Book ch. 15 — `Arc`, `Mutex` (and why `Rc` is wrong)
- [ ] Book ch. 16 — threads, `mpsc`, `Send`/`Sync`
- [ ] Optional ch. 17
- [ ] `ibapi` README: async vs `features = ["sync"]` (reading)

## Why this exists

A later TWS feed will outrun a quote replace.
The book is shared state.
The quoter must not hold the book lock while "submitting."
Velocity: if N book updates arrive inside Δt, emit **one** quote (or none). Document N and Δt.

## You write

Three stages:

1. **Feed** — `MarketData` → bounded channel of `DepthUpdate`
2. **Book** — owns `OrderBook`, applies, forwards a small *snapshot* (inside + sizes + microprice)
3. **Quoter** — `InventoryQuoter` + **velocity filter** → at most one `Quote` per window

Rules:

- Bounded channels (2–4). Slow book: drop or block — pick one, test it
- Prefer the book thread owning the book; the quoter never locks it
- Clean shutdown when the feed ends
- Same JSONL tape → same inside as single-thread `lob`
- Velocity: a burst of 20 updates in one window produces ≤ 1 quote

## Plan of work

### A. Read

- [ ] Book ch. 16 `Mutex<i32>` increment yourself
- [ ] Why `Rc` is wrong

### B. Implement

- [ ] Pipeline + shutdown
- [ ] Determinism vs single-thread replay (inside, not quote-count)
- [ ] Backpressure test
- [ ] Velocity test (too-fast burst)

### C. Notes

- [ ] Which `ibapi` mode you would pick *later* (async default vs sync) and why
- [ ] Why force-flat (lesson 12) must be able to bypass the velocity filter

## Definition of done

You can draw feed / book / quoter and mark `Send` / `Arc` / moved.
`cargo test` includes too-fast → one quote.
Still no socket.

## Stretch

Book ch. 17: async feed, book on one thread. That matches a later `ibapi` subscription.

## References

- https://doc.rust-lang.org/book/ch15-00-smart-pointers.html
- https://doc.rust-lang.org/book/ch16-00-concurrency.html
- https://doc.rust-lang.org/book/ch17-00-async-await.html
- https://github.com/wboayue/rust-ibapi
