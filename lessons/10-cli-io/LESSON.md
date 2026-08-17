# Lesson 10 — CLI and I/O: `lob`

> Official spine: [Book ch. 12](https://doc.rust-lang.org/book/ch12-00-an-io-project.html) · [Command Line Book](https://rust-cli.github.io/book/index.html) (args, output, failure)
> Companion: [Cargo Book — project layout](https://doc.rust-lang.org/cargo/guide/project-layout.html)
> Domain hook: `lob --source tape.jsonl --symbol MES` prints the ladder, microprice, imbalance, and the inventory quoter's bid/ask
> Wire: no host, no port, no `ibapi`

## Contract

JSONL depth from lessons 07/09.
The tutor may not write `main` beyond pointing at Book ch. 12.

## Read first (do not skip)

- [ ] Book ch. 12 — minigrep, *you type it*
- [ ] CLI book: args, exiting on failure
- [ ] Your JSONL format and `InventoryQuoter`

## Why this exists

A desk tool is a binary.
This is that binary, still on recorded depth.

## You write

```text
lob --source <path> --symbol MES|ES [--inv N] [--max-abs M]
```

Behavior:

- Replay the tape into `OrderBook`
- After each update or at EOF (document which), print `best_bid best_ask spread microprice imbalance`
- Run `InventoryQuoter` with `--inv` (default 0) and print the quote
- MES vs ES only changes `FuturesSpec` and printed tick value
- Exit non-zero on `WireError`
- `--help` works
- If someone passes `--port`, run it through `parse_port` and **do not connect**

Tests: snapshot inside + one quote on `tests/data/`.

## Plan of work

### A. Book 12

- [ ] `std::env::args` is enough. `clap` only if you can justify it

### B. Pipeline

- [ ] JSONL works for MES (default) and ES spec
- [ ] `--inv 3` changes the quote vs flat
- [ ] Live port value still errors without a socket

## Definition of done

`lob --help` and one tape produce the same book and quote on a second run.
No socket. No unwrap in `main` except a single top-level `if let Err`.

## References

- https://doc.rust-lang.org/book/ch12-00-an-io-project.html
- https://rust-cli.github.io/book/index.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
