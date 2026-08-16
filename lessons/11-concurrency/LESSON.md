# Lesson 11 — Concurrency: decode, detect, track

> Official spine: [Book ch. 15](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html) · [Book ch. 16](https://doc.rust-lang.org/book/ch16-00-concurrency.html) · optional [Book ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html)
> Companion: [RBE — Threads](https://doc.rust-lang.org/rust-by-example/std_misc/threads.html)
> Contribution target: how you will *serve* a Candle model (one `Arc` model, many frames) without data races
> Domain hook: capture / RF-DETR / ByteTrack-or-McByte as three stages

## Contract

Threads + channels first. Async is optional stretch.
The tutor may show `mpsc::channel`.
The tutor may not write the pipeline.
`unsafe` is forbidden in this lesson.

## Read first (do not skip)

- [ ] Book ch. 15 — `Box`, `Rc`, `RefCell`, `Arc` (focus on `Arc` + `Mutex` / `RwLock`)
- [ ] Book ch. 16 — threads, `Move`, `mpsc`, `Mutex`, `Sync`/`Send`
- [ ] Optional ch. 17 if you already know you want async I/O
- [ ] Candle device note: a `Tensor` is not trivially shared across threads without thinking about the `Device`

## Why this exists

RF-DETR on GPU wants the model loaded once.
opencv capture wants its own thread so a slow detect does not stall the camera.
Tracking is cheap and should not own the GPU.
This lesson builds that shape with a *fake* detector that sleeps, so you can prove the plumbing.

## You write

Three threads (or two + main):

1. **Source** — yields `Frame` (from JSONL or a synthetic generator) into a bounded channel
2. **Detect** — `Detector` impl, owns or `Arc`s the stub model, sends `Vec<Detection>`
3. **Track** — `Tracker` impl, prints or collects `ActiveTrack`

Rules:

- Bounded channels (size 2–4). Prove what happens when detect is slow (drop or block — pick one, test it).
- `Detector` that is `Send`. If it is not `Sync`, do not share it; move it into the detect thread.
- Shut down cleanly when the source ends (no leaked threads)
- Tests: same JSONL clip as lesson 10 produces the same track ids as the single-thread CLI (determinism)

No `unsafe`. No `clone` of pixel buffers except at the documented source→detect handoff.

## Plan of work

### A. Read

- [ ] Write the Book ch. 16 increment example with `Mutex<i32>` yourself
- [ ] Answer: why `Rc` is wrong here

### B. Implement

- [ ] Bounded pipeline
- [ ] Clean shutdown
- [ ] Determinism test vs single-thread

### C. Notes

- [ ] Where a real `candle_core::Device::Cuda` would live (detect thread only)
- [ ] Why McByte's propagated mask must stay on the track thread, not hop back to detect

## Definition of done

You can draw the three stages and mark which type is `Send`, which is `Arc`, and which is moved.
`cargo test` includes a slow-detector backpressure test.

## Stretch

Book ch. 17: rewrite source as async file read. Keep detect on a blocking thread (`spawn_blocking`) because Candle and OpenCV will be.

## References

- https://doc.rust-lang.org/book/ch15-00-smart-pointers.html
- https://doc.rust-lang.org/book/ch16-00-concurrency.html
- https://doc.rust-lang.org/book/ch17-00-async-await.html
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust
