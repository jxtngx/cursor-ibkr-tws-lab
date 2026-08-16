# Lesson 03 — Ownership: frames and views

> Official spine: [Book ch. 4](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
> Companion: Rustlings move semantics; [RBE — Ownership](https://doc.rust-lang.org/rust-by-example/scope/move.html)
> Contribution target: `candle_core::Tensor` is owned; `opencv::core::Mat` is refcounted and *not* a Rust owner
> Domain hook: a video frame is large. Trackers must borrow pixels. Cloning a frame to please rustc is a failed lesson.

## Contract

The tutor explains move vs borrow vs `&mut`.
The tutor does not write your `Frame` type.
No `clone()` unless a test proves the pixels must outlive the source.

## Read first (do not skip)

- [ ] Book ch. 4 in full (ownership, references, slices)
- [ ] Rustlings move-semantics exercises
- [ ] Skim Candle `Tensor` docs enough to see that ops return a new `Tensor` or a `Result<Tensor>`
- [ ] Read the opencv-rust README note on `Mat`: cloning may be required because aliasing is C++-shaped

## Why this exists

RF-DETR inference will own a tensor of images.
opencv `VideoCapture` will give you a `Mat` that does not obey exclusive `&mut`.
ByteTrack only needs boxes (owned, tiny).
McByte needs a mask that *refers* to the same frame over time.
If you do not have a model for "who owns the pixels," you will either leak clones or fight the borrow checker in lesson 11.

## You write

```bash
cd lessons/03-ownership
cargo init --lib --name lesson03
```

Model a tiny image pipeline in `std` only:

- `Frame` owns `width`, `height`, and `pixels: Vec<u8>` (gray8 is enough)
- `fn view(&self) -> FrameView<'_>` that borrows pixels
- `fn pixel(&self, x: u32, y: u32) -> Option<u8>`
- A function `fn crop_copy(src: &Frame, x, y, w, h) -> Option<Frame>` that *must* allocate a new owner
- A function `fn draw_box(frame: &mut Frame, x1, y1, x2, y2, value: u8)` that mutates in place
- Tests that prove:
  - moving `Frame` invalidates the old name (write the test as a comment plus a compiling version that uses the value after move only if you restructure)
  - two shared borrows of `view` can coexist
  - `draw_box` cannot run while a `FrameView` is live (this is a compile-fail thought experiment — write it in `NOTES.md` if you cannot encode it as a test)

Reuse lesson 02's IoU ideas only if you copy the *functions you wrote*, by hand, not by asking an agent to import them.

## Plan of work

### A. Read Book 4 until you can answer

- [ ] What is moved when you pass `Frame` by value?
- [ ] Why `&str` vs `String` is the same question as view vs frame?

### B. Implement

- [ ] `Frame` / `FrameView` / `draw_box` / `crop_copy`
- [ ] Tests for bounds and in-place mutation

### C. Upstream comparison (`NOTES.md`)

- [ ] Three bullets: how `Tensor` ownership differs from `Vec<u8>`
- [ ] Three bullets: why `Mat` clone is not a Rust `Copy` and why that will hurt in lesson 10
- [ ] One rustc error you fixed by changing the *model*, not by cloning

## Definition of done

You can explain, at a whiteboard, who owns a captured frame in a detect-then-track loop.
`cargo test` is green with no `clone` on the happy path of `draw_box`.

## Stretch

Read the signature of one Candle vision example's preprocess function.
Write whether it takes `&[u8]`, `Vec<u8>`, or a `Tensor`.
Say which you want RF-DETR preprocess to take, and why.

## References

- https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust (Mat / shared mutability)
- McByte uses a *propagated mask* as a cue — a borrow over time, not a new image every frame: https://arxiv.org/abs/2506.01373
