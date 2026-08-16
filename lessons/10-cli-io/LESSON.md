# Lesson 10 — CLI and I/O: `rftrack`

> Official spine: [Book ch. 12](https://doc.rust-lang.org/book/ch12-00-an-io-project.html) · [Command Line Book](https://rust-cli.github.io/book/index.html) (selected chapters: args, output, failure)
> Companion: [Cargo Book — project layout](https://doc.rust-lang.org/cargo/guide/project-layout.html)
> Contribution target: opencv-rust `videoio` + `imgproc`; a CLI others can run without your laptop paths
> Domain hook: `rftrack --detector rfdetr-det|rfdetr-seg --tracker byte|mcbyte --source clip.jsonl`

## Contract

The default path uses JSONL detections from lesson 07/09 so nobody needs OpenCV or a GPU.
OpenCV `VideoCapture` is a *feature-gated* stretch (`--features opencv`).
The tutor may not write `main` or clap boilerplate beyond pointing at Book ch. 12's arg parsing.

## Read first (do not skip)

- [ ] Book ch. 12 — the minigrep project, *you type it* (or the equivalent arg/file read in this crate)
- [ ] CLI book: parsing args, exiting on failure
- [ ] opencv-rust `videoio` docs *if* you attempt the stretch
- [ ] RF-DETR inference CLI flags (Python) — steal *flag names*, not code: https://github.com/roboflow/rf-detr

## Why this exists

A Candle example is a binary.
An opencv-rust contribution is often an example that opens a file, draws, and exits.
This lesson is that binary, wired to *your* `Detector` and `Tracker` traits, still on recorded detections.

## You write

Binary crate `rftrack` in the workspace:

```text
rftrack --source <path> --detector stub-det|stub-seg|jsonl --tracker byte|mcbyte [--out tracks.jsonl]
```

Behavior:

- Read frames from JSONL (image size + list of detections) unless `--source` is a video *and* the opencv feature is on
- Run the selected detector stub / jsonl feeder and tracker
- Print `frame_idx track_id class score x1 y1 x2 y2` to stdout
- Exit non-zero on `PipelineError` with a useful `Display`
- `--help` works

Tests: run the binary (or the library entrypoint) on `tests/data/` and snapshot the track ids.

Do not download RF-DETR weights here.

## Plan of work

### A. Book 12

- [ ] File read + args without a giant framework. `std::env::args` is enough. `clap` only if you read its docs and can justify it.

### B. Pipeline

- [ ] Wire lesson 08 traits
- [ ] JSONL source works with both trackers
- [ ] `stub-seg` + `mcbyte` is a supported pair
- [ ] `stub-det` + `mcbyte` still runs (mask cue inert)

### C. Optional OpenCV feature

- [ ] `VideoCapture` from a file, convert `Mat` to your `Frame` *with an explicit copy* (lesson 03)
- [ ] Draw boxes with `imgproc` and write a video or save PNGs
- [ ] If OpenCV is not installed, the feature stays off and the lesson is still done

### D. Notes

- [ ] What you would upstream to opencv-rust (example vs binding fix)
- [ ] What remains for Candle (the real `RfDetr` detector)

## Definition of done

`rftrack --help` and one JSONL clip produce stable track ids on a second run.
No GPU. No unwrap in `main` except a single top-level `if let Err`.

## Stretch

Read opencv-rust issues for `videoio` on your OS.
If you find a real bug, file it *with a minimal repro* — that can be your lesson 12 path B.

## References

- https://doc.rust-lang.org/book/ch12-00-an-io-project.html
- https://rust-cli.github.io/book/index.html
- https://docs.rs/opencv
- https://github.com/twistedfall/opencv-rust
- https://github.com/roboflow/rf-detr
