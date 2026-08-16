# Lesson 07 — Error handling: disconnects, rejects, paper only

> Official spine: [Book ch. 9](https://doc.rust-lang.org/book/ch09-00-error-handling.html) · [RBE — Error handling](https://doc.rust-lang.org/rust-by-example/error.html)
> Companion: Rustlings error-handling, options
> Wire: TWS error codes / notices (2100–2169 informational; 1100-series connectivity). `ibapi` surfaces `Notice` / `Error`
> Domain hook: a missing paper port, a live port, a bad contract, a rejected limit — all recoverable. A live submit is not

## Contract

No `unwrap` / `expect` in library paths.
`unwrap` in tests is allowed when the fixture is statically valid.
The tutor may show `?`.
The tutor may not design your error enum.

## Read first (do not skip)

- [ ] Book ch. 9 — panic vs `Result`, `?`, custom errors
- [ ] RBE error handling
- [ ] TWS API error / system codes enough to name: connectivity broken, farm data, order reject
- [ ] `ibapi` README on `Notice` vs hard errors (read only)

## Why this exists

Lesson 12 will connect to paper TWS and submit one limit.
Both fail in boring ways: port closed, client id in use, contract not found, order rejected, pacing.
This lesson makes those failures a type, and makes **live ports** a type you refuse.

## You write

Crate `lesson07` (or fold into the workspace):

```text
enum WireError { ... }
type Result<T> = std::result::Result<T, WireError>;
```

Required variants (names yours):

- connect failed (IO)
- live port refused (`7496`, `4001` — you reject *before* connect)
- unknown symbol / contract
- book apply failed (from lesson 06)
- order rejected (string or code)
- paper-only violation

Implement `Display` + `std::error::Error`.
Implement `From<std::io::Error>`.

Functions:

- `fn parse_port(port: u16) -> Result<PaperPort>` — `7497` and `4002` ok; `7496` / `4001` → `Err`
- `fn load_depth_jsonl(path: &Path) -> Result<Vec<DepthUpdate>>` — invent a tiny format; document it
- `fn require_contract(symbol: &str) -> Result<FuturesSpec>` — allow `MES`, `ES`, and one commodity micro; reject `AAPL` or empty

Tests for each failure and one success path.
Fixtures under `tests/data/`.

## Plan of work

### A. Read

- [ ] Rewrite a Book ch. 9 example with a custom error, not `Box<dyn Error>`

### B. Implement

- [ ] Error enum + `From`
- [ ] Paper port guard
- [ ] JSONL loader + fixtures
- [ ] `cargo test`
- [ ] clippy `-D warnings`

### C. Notes

- [ ] Copy *signatures only* of `ibapi` `Client::connect` as you found them
- [ ] Write how *your* `WireError` would wrap connect failure
- [ ] List two TWS notice codes you will treat as non-fatal later

## Definition of done

`parse_port(7496)` is `Err`.
A missing file returns `Err`, never panic.
You can add a new variant without touching `?` call sites.

## Stretch

Read `thiserror` vs hand-written `Display`.
Do not add `thiserror` unless you can explain the expand.

## References

- https://doc.rust-lang.org/book/ch09-00-error-handling.html
- https://doc.rust-lang.org/rust-by-example/error.html
- https://interactivebrokers.github.io/tws-api/message_codes.html (or the current TWS error-codes page)
- https://docs.rs/ibapi/
