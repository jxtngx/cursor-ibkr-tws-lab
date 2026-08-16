# Lesson 04 — Structs and enums: detections and track state

> Official spine: [Book ch. 5](https://doc.rust-lang.org/book/ch05-00-structs.html) · [Book ch. 6](https://doc.rust-lang.org/book/ch06-00-enums.html)
> Companion: Rustlings structs, enums; [RBE — Enums](https://doc.rust-lang.org/rust-by-example/custom_types/enum.html)
> Contribution target: the data model a Candle RF-DETR example would return
> Domain hook: RF-DETR det is boxes; RF-DETR seg is boxes plus masks. ByteTrack only looks at boxes. McByte looks at boxes *and* masks.

## Contract

One crate, `std` only.
The tutor may show `enum IpAddr`.
The tutor may not write `TrackState` or `Detection`.

## Read first (do not skip)

- [ ] Book ch. 5 — structs, methods, associated functions
- [ ] Book ch. 6 — enums, `match`, `if let`, `Option`
- [ ] Rustlings structs + enums

## Why this exists

A contribution to `candle-transformers` for RF-DETR will be rejected if "the output" is a pile of parallel `Vec`s.
You need a type that can be a box-only detection *or* a boxed mask, and a track that is `Tentative | Confirmed | Lost` without boolean soup.

## You write

```bash
cd lessons/04-structs-enums
cargo init --lib --name lesson04
```

Types (names yours; behavior not):

- `BBox` with methods from lesson 02 (`area`, `iou`, clamp)
- `ClassId(u32)` newtype
- `Detection` — score, class, box, and `Option<Mask>`
- `Mask` — `width`, `height`, `bits` or `Vec<u8>` (binary is enough)
- `fn mask_bbox_overlap(mask: &Mask, box: BBox) -> f32` — crude is fine (box vs mask bounding box, or pixel count inside the box). Document the rule.
- `TrackState` enum: `Tentative`, `Confirmed { hits: u32 }`, `Lost { age: u32 }`
- `fn TrackState::on_hit(self) -> Self` and `on_miss(self) -> Self` with explicit rules you write in rustdoc:
  - first hit → Tentative
  - N hits → Confirmed
  - miss while Confirmed → Lost
  - miss while Lost past `max_age` → you decide (stay Lost, or `Option::None` to drop)

`match` must be exhaustive.
No `unwrap` on `Option<Mask>` in library paths.

## Plan of work

### A. Read

- [ ] Implement the Book ch. 5 rectangle example yourself before `BBox`
- [ ] Write a `match` on `Option` without `unwrap`

### B. Tests

- [ ] Detection without mask is valid (RF-DETR det)
- [ ] Detection with mask is valid (RF-DETR seg)
- [ ] State machine: Tentative → Confirmed → Lost
- [ ] `on_miss` does not invent a Confirmed track

### C. Domain note (`NOTES.md`)

- [ ] One paragraph: why McByte cannot run on det-only output
- [ ] One paragraph: why ByteTrack can

## Definition of done

You can draw the `TrackState` diagram from memory.
A reviewer can read `Detection` and know what RF-DETR variant produced it.

## Stretch

Read the RF-DETR README task list (detect, segment, keypoint).
Add a `enum RfTask { Detect, Segment }` *without* implementing keypoint.
Do not add a third unused variant "for later."

## References

- https://doc.rust-lang.org/book/ch05-00-structs.html
- https://doc.rust-lang.org/book/ch06-00-enums.html
- https://github.com/roboflow/rf-detr
- https://huggingface.co/Roboflow/rf-detr-segmentation
- McByte (mask cue): https://arxiv.org/abs/2506.01373
- ByteTrack: https://arxiv.org/abs/2110.06864
