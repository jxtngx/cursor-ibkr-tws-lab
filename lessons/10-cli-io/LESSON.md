# Lesson 10 — CLI and I/O: `lob`

> Official spine: [Book ch. 12](https://doc.rust-lang.org/book/ch12-00-an-io-project.html) · [Command Line Book](https://rust-cli.github.io/book/index.html) (args, output, failure)
> Companion: [Cargo Book — project layout](https://doc.rust-lang.org/cargo/guide/project-layout.html)
> Wire: an operator binary others can run without TWS. Lesson 12 will add `--paper` later
> Domain hook: `lob --source tape.jsonl --symbol MES --limit-ticks …` prints the book and a hypothetical fill

## Contract

The default path uses JSONL depth from lessons 07/09.
No `ibapi`. No sockets.
The tutor may not write `main` beyond pointing at Book ch. 12's arg parsing.

## Read first (do not skip)

- [ ] Book ch. 12 — the minigrep project, *you type it* (or the equivalent arg/file read)
- [ ] CLI book: parsing args, exiting on failure
- [ ] Your own `DepthUpdate` JSONL format from lesson 07

## Why this exists

A desk tool is a binary.
This lesson is that binary, wired to *your* `MarketData` + `OrderRouter` traits, still on recorded depth.

## You write

Binary crate `lob` in the workspace:

```text
lob --source <path> --symbol MES|ES|MCL --side bid|ask --qty N [--limit-ticks T] [--out fills.jsonl]
```

Behavior:

- Replay the tape into your `Book`
- After each update (or at EOF — document which), print `best_bid best_ask spread imbalance`
- If `--limit-ticks` is set, submit through `PaperRouter` and print fill / rest
- MES vs ES only changes `FuturesSpec` and printed tick value
- Exit non-zero on `WireError` with a useful `Display`
- `--help` works
- `--port` if present must go through `parse_port` and still not connect

Tests: run the library entrypoint on `tests/data/` and snapshot best bid/ask and one fill.

## Plan of work

### A. Book 12

- [ ] File read + args without a giant framework. `std::env::args` is enough. `clap` only if you read its docs and can justify it

### B. Pipeline

- [ ] Wire lesson 08 traits
- [ ] JSONL source works for MES and ES specs
- [ ] A limit that is not marketable rests
- [ ] A marketable limit fills in the paper router

### C. Notes

- [ ] What `--paper` will mean in lesson 12 (connect, still paper port)
- [ ] Why the CLI default must not take a host/port

## Definition of done

`lob --help` and one JSONL tape produce the same book on a second run.
No socket. No unwrap in `main` except a single top-level `if let Err`.

## Stretch

Print a 5-level ladder.
Keep it `std`.

## References

- https://doc.rust-lang.org/book/ch12-00-an-io-project.html
- https://rust-cli.github.io/book/index.html
- https://interactivebrokers.github.io/tws-api/market_depth.html
