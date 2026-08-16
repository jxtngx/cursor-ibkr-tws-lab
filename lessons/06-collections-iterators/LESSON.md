# Lesson 06 — Collections and iterators: ByteTrack association

> Official spine: [Book ch. 8](https://doc.rust-lang.org/book/ch08-00-common-collections.html) · [Book ch. 13](https://doc.rust-lang.org/book/ch13-00-functional-features.html)
> Companion: Rustlings vecs, hashmaps, iterators; [RBE — Iterators](https://doc.rust-lang.org/rust-by-example/trait/iter.html)
> Contribution target: the association kernel of ByteTrack, in `std`, good enough to later sit under a Candle example
> Domain hook: ByteTrack matches *every* box, high score first, then low score. McByte will add a mask cue on top of this, not instead of it.

## Contract

`std` only. No ndarray, no nalgebra, no Hungarian crate unless you implement the assignment yourself and can explain it.
The tutor may not write `associate`.
A greedy IoU matcher is acceptable if documented; a real Hungarian is stretch.

## Read first (do not skip)

- [ ] Book ch. 8 — `Vec`, `String`, `HashMap`
- [ ] Book ch. 13 — closures, iterators, `Iterator` adapters
- [ ] ByteTrack paper §3 (two-stage association): https://arxiv.org/abs/2110.06864
- [ ] Optional: Roboflow ByteTrack note: https://trackers.roboflow.com/latest/trackers/bytetrack/

## Why this exists

You do not need a GPU to learn MOT.
RF-DETR will only be useful in this lab if something consumes its boxes every frame.
This lesson is that something: `HashMap<TrackId, Track>`, a predicted box, IoU, two thresholds.

McByte ([arxiv 2506.01373](https://arxiv.org/abs/2506.01373)) is ByteTrack plus a temporally propagated *mask* as an extra association cue.
If ByteTrack is not correct, McByte is cosplay.

## You write

In the workspace from lesson 05 (or `lessons/06-collections-iterators` if you have not split crates yet):

```text
fn associate(
    tracks: &HashMap<TrackId, Track>,
    detections: &[Detection],
    high_thresh: f32,
    low_thresh: f32,
    match_iou: f32,
) -> AssocResult
```

`AssocResult` contains matched pairs, unmatched track ids, unmatched detections.

Required behavior:

1. Split detections into high (`score >= high_thresh`) and low (`low_thresh <= score < high_thresh`). Drop below `low_thresh`.
2. Match high detections to tracks by IoU ≥ `match_iou`.
3. Match remaining tracks to low detections the same way.
4. Unmatched high detections become new tracks (caller can assign ids).
5. Unmatched tracks are misses (lesson 04 `on_miss`).

Use iterators for filter/partition/collect.
Tests with hand-built frames. No video.

## Plan of work

### A. Read

- [ ] Implement two Book ch. 8 exercises (mean of a list, word count) yourself, then stop
- [ ] Write the two-stage algorithm in comments *before* code

### B. Tests (table-driven)

- [ ] One track, one high det, IoU 1.0 → match
- [ ] One track, only a low-score det that overlaps → second-stage match (the ByteTrack point)
- [ ] Low-score det with no overlap → unmatched, not a new track
- [ ] High-score det with no overlap → new track
- [ ] Two tracks, two dets, crossing IoUs — document how ties break

### C. Notes

- [ ] Where Kalman prediction would plug in (you may stub `predict()` as "box unchanged")
- [ ] One sentence McByte would add: a mask-overlap term next to IoU

## Definition of done

You can explain ByteTrack's two stages to someone who has only used SORT.
`cargo test` covers high-only, low-recovery, and spawn/kill.

## Stretch

Read McByte §3 enough to name the extra cue (propagated mask).
Add a `fn mask_cue_score(...)` stub that returns `0.0` and a rustdoc pointing at the paper. Do not fake the propagation.

## References

- https://doc.rust-lang.org/book/ch08-00-common-collections.html
- https://doc.rust-lang.org/book/ch13-00-functional-features.html
- https://arxiv.org/abs/2110.06864
- https://github.com/FoundationVision/ByteTrack
- https://arxiv.org/abs/2506.01373
- https://github.com/tstanczyk95/McByte
