---
name: curriculum-plan
description: Master 12-lesson SuperGrok Rust curriculum. Use when the user asks what lesson they are on, what to read next, or how a lesson maps to Candle, opencv-rust, RF-DETR, ByteTrack, or McByte. Open the matching lessons/NN-*/LESSON.md for the spec.
---

# 12-lesson curriculum

Source of truth for sequence: [lessons/README.md](../../../lessons/README.md).
Official index: [Learn Rust](https://www.rust-lang.org/learn/).

## Intent

Take a beginner to a first contribution on [huggingface/candle](https://github.com/huggingface/candle) or [twistedfall/opencv-rust](https://github.com/twistedfall/opencv-rust), fast, without replacing the Book.

Application destination: Roboflow RF-DETR (detection + segmentation) feeding ByteTrack or McByte (mask-cued ByteTrack).

## Bias

- Official tutorial over a homemade language syllabus.
- Student types the code. Agents quiz and review.
- Domain types appear early (bbox, detection, track) so later PRs are not a shock.
- No GPU required until lesson 12.

## The arc

| Lessons | Theme | Upstream |
| --- | --- | --- |
| 01–04 | rustup through enums | read Candle and opencv-rust; own the data model |
| 05–08 | crates, iterators, `Result`, traits | API a contributor would actually open a PR with |
| 09–11 | tests, CLI, threads | PR bar + a real pipeline on recorded detections |
| 12 | unsafe / FFI + one contribution | RF-DETR in Candle **or** video I/O in opencv-rust |

## Agent rules

When `@start-lesson N` runs:

1. Open `lessons/NN-*/LESSON.md`.
2. Confirm the student has done **Read first**.
3. Explain the one official concept. Ten to twenty lines, not the exercise.
4. Stop. The student creates the crate and writes the tests.
5. After they have a diff, `@review-rust`.

Do not implement `src/`.
Do not invent a thirteenth parallel syllabus.

## Contribution targets

| Target | Why it is in this lab |
| --- | --- |
| `candle-transformers` + `candle-examples` | Candle already has DINOv2, YOLO-v8, SAM, SegFormer. RF-DETR is the missing real-time DETR. |
| `opencv-rust` (`videoio`, `imgproc`, `core::Mat`) | Capture, draw boxes/masks, understand FFI `Mat`. |
| ByteTrack / McByte in *this* repo | Association is std-only until lesson 12. McByte needs RF-DETR Seg masks. |

## Rubric (every lesson)

Advance only if the student, not the model, can:

1. Name the Book chapter and the one concept.
2. Explain the last rustc error they hit.
3. Show green `cargo test` and clippy `-D warnings`.
4. Re-type the core function from a blank file.
