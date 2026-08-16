# Lessons

Twelve lessons from [Learn Rust](https://www.rust-lang.org/learn/) to a first contribution on [Candle](https://github.com/huggingface/candle) or [opencv-rust](https://github.com/twistedfall/opencv-rust).

The application you are aiming at is Roboflow [RF-DETR](https://github.com/roboflow/rf-detr) (detection and segmentation) plus [ByteTrack](https://github.com/FoundationVision/ByteTrack) or [McByte](https://github.com/tstanczyk95/McByte) (mask-cued ByteTrack).

You write every crate.
Agents open `LESSON.md`, quiz you, and review.
They do not implement the exercise.

| # | Folder | Official spine | You build | Upstream it prepares |
| --- | --- | --- | --- | --- |
| 01 | [01-getting-started](01-getting-started/LESSON.md) | Book 1–2, rustup | Cargo hello, walk both repos | clone / build literacy |
| 02 | [02-language-foundations](02-language-foundations/LESSON.md) | Book 3, RBE primitives | `BBox`, IoU, xyxy / xywh | postprocess types |
| 03 | [03-ownership](03-ownership/LESSON.md) | Book 4, rustlings moves | owned frame, borrowed view | `Tensor` vs `Mat` |
| 04 | [04-structs-enums](04-structs-enums/LESSON.md) | Book 5–6 | `Detection`, `Mask`, `TrackState` | RF-DETR det vs seg |
| 05 | [05-crates-modules](05-crates-modules/LESSON.md) | Book 7, Cargo Book | workspace `geom` / `det` / `track` | candle-transformers layout |
| 06 | [06-collections-iterators](06-collections-iterators/LESSON.md) | Book 8, 13 | ByteTrack two-stage associate | tracker PR |
| 07 | [07-error-handling](07-error-handling/LESSON.md) | Book 9 | typed load / empty-frame errors | Candle / OpenCV `Result` |
| 08 | [08-traits-lifetimes](08-traits-lifetimes/LESSON.md) | Book 10 | `Detector` + `Tracker` traits | contribution API |
| 09 | [09-tests-docs](09-tests-docs/LESSON.md) | Book 11, rustdoc | table-driven tests, rustdoc | PR bar |
| 10 | [10-cli-io](10-cli-io/LESSON.md) | Book 12, CLI book | `rftrack` on JSONL + optional `VideoCapture` | opencv-rust videoio |
| 11 | [11-concurrency](11-concurrency/LESSON.md) | Book 15–16 | decode / detect / track threads | serving a Candle model |
| 12 | [12-contribute](12-contribute/LESSON.md) | Book 20, Nomicon 1–3 | RF-DETR in Candle **or** video example in opencv-rust, plus ByteTrack / McByte | first real PR |

## How to start a lesson

1. Read the official links in that `LESSON.md` *before* you prompt.
2. `@start-lesson 01` (or the next unfinished number).
3. Create the crate yourself:

```bash
cd lessons/01-getting-started
cargo init --name lesson01
```

4. Write the tests first when the lesson says so.
5. `@review-rust` only after `cargo test` is green.

## What must not happen

- An agent filling `src/` because you asked it to "just make it compile."
- A complete ByteTrack or RF-DETR dumped into this repo as a solution.
- Skipping the Book chapter because the domain hook looks more fun.
