# Lesson 08 — Traits and lifetimes: Detector and Tracker

> Official spine: [Book ch. 10](https://doc.rust-lang.org/book/ch10-00-generics.html)
> Companion: Rustlings generics, traits, lifetimes; [RBE — Traits](https://doc.rust-lang.org/rust-by-example/trait.html)
> Contribution target: the API a Candle example and an opencv capture loop would share
> Domain hook: RF-DETR det and RF-DETR seg are two `Detector` impls. ByteTrack and McByte are two `Tracker` impls.

## Contract

This is the contribution API lesson.
The tutor may show `fn notify(item: &impl Summary)`.
The tutor may not write `trait Detector`.
Stubs for inference are required. Real weights are lesson 12.

## Read first (do not skip)

- [ ] Book ch. 10 — generics, traits, trait bounds, lifetimes
- [ ] Rustlings traits + lifetimes
- [ ] Skim Candle's pattern: a model struct + `forward` / `load` (pick YOLO-v8 or DINOv2)
- [ ] Skim RF-DETR README: one architecture, detect vs segment vs keypoint

## Why this exists

If detection is a pile of free functions, you cannot swap RF-DETR det for RF-DETR seg, or ByteTrack for McByte, without rewriting the CLI.
A PR to Candle examples should look like: load model → `detect(&frame) -> Result<Vec<Detection>>` → `tracker.step(dets) -> Vec<Track>`.
Lifetimes show up when a detection *borrows* a frame or a mask *borrows* a buffer. Prefer owned outputs in the public trait unless you can name the source.

## You write

```text
trait Detector {
    fn name(&self) -> &'static str;
    fn detect(&mut self, frame: &Frame) -> Result<Vec<Detection>>;
}

trait Tracker {
    fn step(&mut self, detections: &[Detection]) -> Result<Vec<ActiveTrack>>;
}
```

Impls (all in-process, no GPU):

- `JsonlDetector` — reads the lesson 07 fixture, one frame per `detect` call (stand-in for RF-DETR)
- `StubRfDetrDet` — returns boxes only (`mask: None`)
- `StubRfDetrSeg` — returns boxes plus a dummy full-frame mask
- `ByteTracker` — lesson 06 associate
- `McByteTracker` — same as ByteTrack, but *if* a detection has a mask, fold `mask_bbox_overlap` into the match score (document the blend). If no mask, behave like ByteTrack.

Lifetime rule:

- `detect` must not return references into `frame` unless `'frame` is on the return type and you can defend it
- Prefer owned `Detection` (lesson 03–04)

## Plan of work

### A. Read

- [ ] Write the Book ch. 10 `NewsArticle` / `Summary` example yourself
- [ ] Write one function that needs an explicit `'a` and one that should use elision

### B. Implement

- [ ] Traits + five impls
- [ ] A generic `fn run_clip<D: Detector, T: Tracker>(...)` used by tests
- [ ] Tests: det-only path works with ByteTrack; seg path gives McByte a mask to use; det path with McByte still works (falls back)

### C. Notes

- [ ] Would Candle want `Detector` in `candle-transformers` or only in the example? Argue in five sentences.
- [ ] Would opencv-rust want any of this? (Probably not — it wants `Mat` in and `Mat` out. Your tracker stays your crate.)

## Definition of done

Swapping `StubRfDetrDet` + `ByteTracker` for `StubRfDetrSeg` + `McByteTracker` is a type-parameter change, not a rewrite.
No `'static` escape hatches on frames.

## Stretch

Read DINOv2 in Candle (RF-DETR's backbone family).
List the types you would need for a real `RfDetr` impl of `Detector`.

## References

- https://doc.rust-lang.org/book/ch10-00-generics.html
- https://github.com/huggingface/candle (YOLO-v8, DINOv2, SAM, SegFormer)
- https://github.com/roboflow/rf-detr
- https://arxiv.org/abs/2506.01373 (McByte)
- https://arxiv.org/abs/2110.06864 (ByteTrack)
