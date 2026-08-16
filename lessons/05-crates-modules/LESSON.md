# Lesson 05 — Crates and modules: a workspace shaped like a desk

> Official spine: [Book ch. 7](https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html) · [Cargo Book — Starting](https://doc.rust-lang.org/cargo/guide/creating-a-new-package.html) · [Cargo Book — Workspaces](https://doc.rust-lang.org/cargo/reference/workspaces.html)
> Companion: Rustlings modules
> Wire: read how [`ibapi`](https://github.com/wboayue/rust-ibapi) splits `contracts`, `orders`, `market_data`, `Client`. You are not adding that crate yet
> Domain hook: `tick`, `book`, `order` are the three crates a futures stack actually needs

## Contract

You create the workspace.
The tutor does not edit `Cargo.toml` for you after the first "where does [workspace] go" hint.
Do not add `ibapi` as a dependency yet.

## Read first (do not skip)

- [ ] Book ch. 7 — packages, crates, modules, `pub`, paths
- [ ] Cargo Book: creating a package + workspaces
- [ ] Walk `ibapi`'s module map on docs.rs (`contracts`, `orders`, client, subscriptions)
- [ ] Walk [ib-interface](https://github.com/jxtngx/ib-interface) only far enough to see it is a *different language*. Do not port modules

## Why this exists

A useful trading crate is a *small* public surface.
`ibapi` puts wire types in the client crate.
Your *domain* (ticks, book apply, order state) should not import a socket.
Lesson 12 is an adapter. This lesson builds that reflex.

## You write

Under `lessons/05-crates-modules/` (keep the repo root clean):

```
tick/     # Tick, FuturesSpec, MES/ES math (lessons 02/04)
book/     # Book, Level, DepthUpdate (lesson 03)
order/    # Side, Tif, Order, OrderStatus
```

Rules:

- Virtual workspace
- `book` and `order` may depend on `tick` — no cycles
- `lib.rs` is a map (`mod` + `pub use` of the small API)
- Internal helpers stay private
- Each crate has at least one unit test

Also write `NOTES.md`:

- Where an `ibapi` adapter would live later (`wire/` or `ibkr/`, *not* inside `book`)
- Which `ibapi` module maps to each of your crates
- Why `book` must not depend on `ibapi`

## Plan of work

### A. Read ch. 7 until you can answer

- [ ] `mod foo;` vs `mod foo { }`
- [ ] `pub(crate)` vs `pub`
- [ ] What a virtual workspace is

### B. Split the types you already wrote

- [ ] Copy by hand from earlier lessons. Do not ask an agent to "just move the files."
- [ ] `cargo test --workspace`
- [ ] `cargo clippy --workspace --all-targets -- -D warnings`

### C. Read-only `ibapi` map

- [ ] List the modules you will call in lesson 12 (`Client`, `Contract::futures`, orders, market depth if you found it)
- [ ] One sentence: your `Book::apply` stays yours; `ibapi` only produces `DepthUpdate`s

## Definition of done

`tree` of your workspace makes sense to a stranger.
You can say, without opening GitHub, which crate must never import `ibapi`.

## Stretch

Sketch `wire/README.md` with the *files* you would add in lesson 12. No code.

## References

- https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html
- https://doc.rust-lang.org/cargo/reference/workspaces.html
- https://docs.rs/ibapi/
- https://github.com/wboayue/rust-ibapi
