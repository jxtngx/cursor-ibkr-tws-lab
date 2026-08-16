# Lesson 11 — Concurrency: feed, book, router

> Official spine: [Book ch. 15](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html) · [Book ch. 16](https://doc.rust-lang.org/book/ch16-00-concurrency.html) · optional [Book ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html)
> Companion: [RBE — Threads](https://doc.rust-lang.org/rust-by-example/std_misc/threads.html)
> Wire: `ibapi` v3 default is async Tokio; the *sync* feature is a blocking client. You will pick one in lesson 12. This week is threads + channels so the model is visible
> Domain hook: depth callbacks must not hold the book lock while submitting an order

## Contract

Threads + channels first. Async is optional stretch.
The tutor may show `mpsc::channel`.
The tutor may not write the pipeline.
`unsafe` is forbidden in this lesson.
No `ibapi` yet.

## Read first (do not skip)

- [ ] Book ch. 15 — `Box`, `Rc`, `RefCell`, `Arc` (focus on `Arc` + `Mutex`)
- [ ] Book ch. 16 — threads, `Move`, `mpsc`, `Mutex`, `Sync`/`Send`
- [ ] Optional ch. 17 if you already know you want async for `ibapi` default
- [ ] `ibapi` README: async vs `features = ["sync"]`

## Why this exists

TWS will push depth faster than you should block on an order ack.
The book is shared state.
The router must not be called with the book lock held if `apply` and `submit` can deadlock.
This lesson builds that shape with a *fake* feed that sleeps.

## You write

Three threads (or two + main):

1. **Feed** — `MarketData` impl yields `DepthUpdate` into a bounded channel
2. **Book** — applies updates, publishes a *snapshot* (owned best bid/ask, or a cloned small snapshot you can defend) to the router
3. **Router** — may submit a scripted MES limit once the spread is ≤ N ticks

Rules:

- Bounded channels (size 2–4). Prove what happens when apply is slow (drop or block — pick one, test it)
- `Book` behind `Mutex` only if you must; prefer the book thread owns the book and the router never locks it
- Shut down cleanly when the feed ends
- Tests: same JSONL tape as lesson 10 produces the same best bid/ask as single-thread `lob`

No `unsafe`. No `clone` of the full book unless `NOTES.md` says why a snapshot is required.

## Plan of work

### A. Read

- [ ] Write the Book ch. 16 increment example with `Mutex<i32>` yourself
- [ ] Answer: why `Rc` is wrong here

### B. Implement

- [ ] Bounded pipeline
- [ ] Clean shutdown
- [ ] Determinism test vs single-thread replay
- [ ] Backpressure test with a slow book

### C. Notes

- [ ] Which `ibapi` mode you will use in 12 (async default vs sync) and why
- [ ] Where a second book (ES) would live — second feed thread, not a second process

## Definition of done

You can draw the three stages and mark which type is `Send`, which is `Arc`, and which is moved.
`cargo test` includes a slow-feed backpressure test.
Still no socket.

## Stretch

Book ch. 17: rewrite the feed as async. Keep the book on one thread. This matches `ibapi` async subscriptions better.

## References

- https://doc.rust-lang.org/book/ch15-00-smart-pointers.html
- https://doc.rust-lang.org/book/ch16-00-concurrency.html
- https://doc.rust-lang.org/book/ch17-00-async-await.html
- https://github.com/wboayue/rust-ibapi
