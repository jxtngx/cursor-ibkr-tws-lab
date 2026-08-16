# Lesson 12 — Unsafe, FFI, and a real contribution

> Official spine: [Book ch. 20](https://doc.rust-lang.org/book/ch20-00-advanced-features.html) (unsafe, advanced traits) · [Nomicon ch. 1–3](https://doc.rust-lang.org/nomicon/) · [Reference](https://doc.rust-lang.org/reference/) as needed
> Companion: [Compiler Error Index](https://doc.rust-lang.org/error-index.html) · opencv-rust binding-generator notes · Candle YOLO-v8 / DINOv2 examples
> Contribution target: **one** upstream PR or a draft PR + issue — Candle *or* opencv-rust
> Domain hook: RF-DETR det/seg in Candle, or video I/O + draw in opencv-rust, driving *your* ByteTrack or McByte

## Contract

This is the only lesson that may touch `unsafe`, FFI, CUDA features, or a third-party model weight file.
The tutor may map files in Candle or opencv-rust.
The tutor may not port RF-DETR or write the binding for you.
If the model starts implementing the architecture, stop it.

Pick **one** path. Finish it. Do not start both.

## Read first (do not skip)

- [ ] Book ch. 20 — `unsafe`, raw pointers, FFI, when not to
- [ ] Nomicon: introductions, aliasing, owning data (first three chapters)
- [ ] The contribution guide / README of the repo you will patch
- [ ] RF-DETR paper or README enough to name backbone (DINOv2) and heads (det vs seg): https://github.com/roboflow/rf-detr
- [ ] Path A extra: Candle `yolo-v8` *and* `dinov2` examples, plus `candle-transformers` model module layout
- [ ] Path B extra: opencv-rust `INSTALL.md`, `videoio`, `imgproc`, binding-generator README

## Why this exists

Lessons 01–11 exist so this PR is boring in the right ways: ownership, `Result`, tests, a small public surface.
The destination stack is:

```text
video (opencv-rust VideoCapture or a file)
  → RF-DETR det or RF-DETR seg (Candle, ideally)
  → ByteTrack (boxes) or McByte (boxes + propagated masks)
  → drawn tracks (opencv imgproc) / JSONL
```

Candle already has DINOv2, YOLO-v8, SAM, SegFormer.
It does not ship RF-DETR.
That is a legitimate first model PR if the forward pass is honest and tested on CPU with a tiny fixture.

opencv-rust already has capture and draw.
A first PR is more likely an example, a doc fix, or a binding gap you actually hit on your OS.

McByte ([arxiv 2506.01373](https://arxiv.org/abs/2506.01373)) needs segmentation masks.
Pair it with RF-DETR seg.
ByteTrack pairs with RF-DETR det.

## Path A — Candle: RF-DETR

You write, in a **fork** of Candle (not vendored into this repo unless you are only prototyping):

1. A model module following `candle-transformers` conventions
2. Weight load from `safetensors` (Roboflow's published checkpoints or a trimmed fixture)
3. Preprocess that matches the official RF-DETR Python *numerically* on one image (document the max abs error)
4. Postprocess into *your* `Detection` type (boxes, scores, labels, optional masks)
5. An example binary: image or short video → detections
6. CPU test with a fixture tensor so CI does not need a GPU
7. Wire the example to *your* `Tracker` (ByteTrack for det, McByte for seg) — the tracker can stay in this lab repo

Definition of done for path A:

- [ ] `cargo test` for the new module on CPU
- [ ] rustdoc on the public load/forward API
- [ ] A draft PR or issue on `huggingface/candle` with the file list and the numerical check
- [ ] `NOTES.md` here links the PR

## Path B — opencv-rust: video I/O that is contribution-quality

You write, in a **fork** of opencv-rust or as an example they would accept:

1. Open a video file (`VideoCapture`), not a webcam (CI-hostile)
2. Convert `Mat` → a buffer your detector can consume, with the aliasing story written down (lesson 03)
3. Draw boxes / mask contours / track ids with `imgproc`
4. Write an output video or image sequence
5. Feature flags documented (`videoio`, `imgproc`)
6. If you hit a binding bug: a minimal failing test and an issue — that *is* the contribution

Definition of done for path B:

- [ ] Example runs on a short checked-in or URL-documented clip
- [ ] No camera required
- [ ] Draft PR or issue on `twistedfall/opencv-rust`
- [ ] Tracker still yours; OpenCV does not need to own ByteTrack

## Shared plan of work

### A. Choose and declare

- [ ] Write `lessons/12-contribute/PATH.md` with one word: `candle` or `opencv-rust`
- [ ] Name the tracker: `byte` or `mcbyte` and why (det vs seg)

### B. Read the existing pattern

- [ ] Path A: copy the *file list* of YOLO-v8 or DINOv2 into `NOTES.md` (paths only)
- [ ] Path B: copy the *file list* of one videoio example

### C. Unsafe budget

- [ ] Every `unsafe` block has a `// SAFETY:` comment that names the invariant
- [ ] No `unsafe` to silence the borrow checker (Nomicon will shame you)

### D. Integrate *your* tracker

- [ ] `rftrack` from lesson 10 grows a `--backend candle` or `--backend opencv` flag that you implement
- [ ] JSONL path still works so reviewers without weights can run tests

### E. Upstream

- [ ] Open the issue/PR yourself
- [ ] Do not paste an agent-generated "complete model" as the PR body

## Definition of done

There is a public URL (issue or PR) on Candle or opencv-rust.
This lab's tests still pass without that fork.
You can explain every `unsafe` line you added, or you added none.

## What this lesson is not

- A request to dump RF-DETR Python into Rust via an agent
- A request to vendor Candle or OpenCV into `supergrok-rust`
- A keypoint-detection side quest
- Training. Inference and tracking only.

## References

- https://doc.rust-lang.org/book/ch20-00-advanced-features.html
- https://doc.rust-lang.org/nomicon/
- https://www.rust-lang.org/learn/
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust
- https://github.com/roboflow/rf-detr
- https://huggingface.co/Roboflow
- https://arxiv.org/abs/2511.09554 (RF-DETR)
- https://arxiv.org/abs/2110.06864 (ByteTrack)
- https://github.com/FoundationVision/ByteTrack
- https://arxiv.org/abs/2506.01373 (McByte)
- https://github.com/tstanczyk95/McByte
