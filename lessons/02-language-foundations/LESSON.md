# Lesson 02 — Language foundations: a bounding box

> Official spine: [Book ch. 3](https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html) · [Rust by Example — Primitives](https://doc.rust-lang.org/rust-by-example/primitives.html) · [RBE — Functions](https://doc.rust-lang.org/rust-by-example/fn.html)
> Companion: Rustlings variables, functions, if, primitive types
> Contribution target: postprocess types every detector crate needs
> Domain hook: RF-DETR emits boxes; ByteTrack and McByte consume them. IoU is the first real algorithm.

## Contract

No crates beyond `std`.
No `Detection` enum yet (that is lesson 04).
The tutor may show a 15-line `fn add` example.
The tutor may not write `iou`.

## Read first (do not skip)

- [ ] Book ch. 3 — variables, types, functions, comments, control flow
- [ ] RBE primitives + functions
- [ ] Rustlings through primitive types and if (stop before move semantics)

## Why this exists

Candle YOLO postprocess and every MOT tracker spend a surprising amount of time on `xyxy`, `xywh`, clamp-to-image, and intersection-over-union.
If those are sloppy `f64` soups, your later RF-DETR port will be unreviewable.
This lesson makes the numbers into functions you can test.

## You write

```bash
cd lessons/02-language-foundations
cargo init --lib --name lesson02
```

Public API (you choose field names; tests must cover the behavior):

- `xyxy` box: `x1, y1, x2, y2` as `f32`
- `area`
- `clamp` to an image width/height (`u32`)
- `iou(a, b) -> f32` in `[0, 1]`, `0` if no overlap
- `xyxy_to_xywh` and `xywh_to_xyxy`
- invalid boxes (x2 < x1, negative width) are not panics in library code — pick a rule and test it (`None`, `0.0` area, or a later `Result`; document it)

Use functions and `if`.
Structs are allowed if you already peeked at ch. 5; they are not required.

## Plan of work

### A. Read

- [ ] Finish Book ch. 3 including the Fibonacci / temp conversion exercises *in your head or on paper*, then decide which ideas you need for IoU

### B. Tests first

- [ ] Identical boxes → IoU `1.0`
- [ ] Disjoint boxes → `0.0`
- [ ] Partial overlap with a known hand-computed value
- [ ] Zero-area box → `0.0` (or your documented rule)
- [ ] Clamp: a box hanging off the right edge is cut, not shifted

### C. Implement until tests pass

- [ ] `cargo test`
- [ ] `cargo clippy --all-targets -- -D warnings`

### D. Recap (you write three bullets in `NOTES.md`)

- [ ] What `f32` vs `f64` means for pixel coordinates
- [ ] Why IoU of `0.3` vs `0.7` changes ByteTrack's high/low score path later
- [ ] One rustc error you hit and the actual cause

## Definition of done

You can write `iou` again from a blank file and defend the no-overlap case.
You have not used `unwrap` to silence a conversion.

## Stretch

Read how Candle's YOLO-v8 example names its box type (do not copy the file).
Write three sentences: what you would keep, what you would rename for a contribution.

## References

- https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html
- https://doc.rust-lang.org/rust-by-example/primitives.html
- ByteTrack paper, §3 (association uses IoU): https://arxiv.org/abs/2110.06864
- RF-DETR (what will emit the boxes): https://github.com/roboflow/rf-detr
