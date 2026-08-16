# Lesson 05 — Crates and modules: a workspace shaped like Candle

> Official spine: [Book ch. 7](https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html) · [Cargo Book — Starting](https://doc.rust-lang.org/cargo/guide/creating-a-new-package.html) · [Cargo Book — Workspaces](https://doc.rust-lang.org/cargo/reference/workspaces.html)
> Companion: Rustlings modules
> Contribution target: you cannot PR `candle-transformers` if you do not understand `mod` / `pub` / workspace members
> Domain hook: `geom`, `det`, `track` are the three crates a MOT stack actually needs

## Contract

You create the workspace.
The tutor does not edit `Cargo.toml` for you after the first "where does [workspace] go" hint.
Do not add Candle or opencv as dependencies yet.

## Read first (do not skip)

- [ ] Book ch. 7 — packages, crates, modules, `pub`, paths
- [ ] Cargo Book: creating a package + workspaces
- [ ] Walk Candle's top-level `Cargo.toml` (members: `candle-core`, `candle-nn`, `candle-transformers`, `candle-examples`, …)
- [ ] Walk opencv-rust features (`videoio`, `imgproc`, `dnn`, `tracking`) — features are not modules, but they split the public surface the same way

## Why this exists

A useful contribution is a *small* public surface.
Candle puts ops in `candle-core`, layers in `candle-nn`, and named models in `candle-transformers/src/models/`.
Your RF-DETR port will be one file (or folder) under `models/`, not a rewrite of `Tensor`.
This lesson builds that reflex in *your* workspace.

## You write

At the **repository root** (or under `lessons/05-crates-modules/` if you prefer to keep the root clean — pick one and document it):

```
geom/     # bbox, iou (move lesson 02/04 types here)
det/      # Detection, Mask
track/    # TrackState
```

Rules:

- Root `Cargo.toml` is a virtual workspace
- `track` depends on `det` depends on `geom` — no cycles
- `lib.rs` is a map (`mod` + `pub use` of the small API)
- Internal helpers stay private
- Each crate has at least one unit test

Also write `NOTES.md`:

- Where an RF-DETR *model* would live in Candle (`candle-transformers`)
- Where an RF-DETR *example* would live (`candle-examples/examples/rf-detr`)
- Where a `VideoCapture` snippet would live in opencv-rust (docs/examples, not the binding generator, unless you are fixing a binding)

## Plan of work

### A. Read ch. 7 until you can answer

- [ ] `mod foo;` vs `mod foo { }`
- [ ] `pub(crate)` vs `pub`
- [ ] What a virtual workspace is

### B. Split the types you already wrote

- [ ] Copy by hand from earlier lessons. Do not ask an agent to "just move the files."
- [ ] `cargo test --workspace`
- [ ] `cargo clippy --workspace --all-targets -- -D warnings`

### C. Read-only Candle map

- [ ] List five entries under `candle-transformers` models that are vision (DINOv2, YOLO, SAM, SegFormer, …)
- [ ] One sentence: RF-DETR is closer to which of those, and why (DETR/DINO family vs YOLO postprocess)

## Definition of done

`tree` of your workspace makes sense to a stranger.
You can say, without opening GitHub, which Candle crate you will patch in lesson 12.

## Stretch

Sketch a `contrib/rf-detr.md` with the *files* you would add to Candle. No code.

## References

- https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html
- https://doc.rust-lang.org/cargo/reference/workspaces.html
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust
