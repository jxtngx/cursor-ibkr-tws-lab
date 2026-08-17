# Lesson 05 — Crates and modules: a workspace shaped like a desk

> Official spine: [Book ch. 7](https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html) · [Cargo Book — Starting](https://doc.rust-lang.org/cargo/guide/creating-a-new-package.html) · [Cargo Book — Workspaces](https://doc.rust-lang.org/cargo/reference/workspaces.html)
> Companion: Rustlings modules
> Wire (reading): how [`ibapi`](https://github.com/wboayue/rust-ibapi) splits `contracts`, `orders`, `market_data`. You do not add that crate
> Domain hook: `tick`, `book`, `order`, `risk` — the socket never lives in `book`

## Contract

You create the workspace.
The tutor does not edit `Cargo.toml` after one hint.
No `ibapi` / `prost`.

## Read first (do not skip)

- [ ] Book ch. 7 — packages, crates, modules, `pub`
- [ ] Cargo Book: package + workspaces
- [ ] `ibapi` module map on docs.rs (names only)

## Why this exists

A later protobuf adapter is a *small* crate on the edge.
`OrderBook::apply` and `Quoter` must not import a socket.

## You write

Under `lessons/05-crates-modules/`:

```
tick/     # Tick, FuturesSpec, MES/ES math
book/     # OrderBook, DOMLevel, DepthUpdate
order/    # Side, Tif, Order, Inventory
risk/     # empty public surface + one placeholder test (session/force-flat land in 12)
```

Rules:

- Virtual workspace
- `book` and `order` may depend on `tick`; `risk` may depend on `order` — no cycles
- `lib.rs` is a map
- Each crate has at least one unit test

`NOTES.md`:

- Where a later `wire/` adapter would live (*not* inside `book`)
- Which `ibapi` module maps to which crate
- Why `book` must never depend on `ibapi`

## Plan of work

### A. Read ch. 7

- [ ] `mod foo;` vs `mod foo { }`
- [ ] `pub(crate)` vs `pub`
- [ ] Virtual workspace

### B. Split types by hand

- [ ] Copy from earlier lessons yourself
- [ ] `cargo test --workspace`
- [ ] `cargo clippy --workspace --all-targets -- -D warnings`

### C. Map

- [ ] One sentence: `OrderBook::apply` stays yours; a later adapter only produces `DepthUpdate`s

## Definition of done

A stranger can read the workspace and see where protobuf would plug in without opening `book`.

## References

- https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html
- https://doc.rust-lang.org/cargo/reference/workspaces.html
- https://docs.rs/ibapi/
