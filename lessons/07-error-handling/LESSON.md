# Lesson 07 — Error handling: video, weights, empty frames

> Official spine: [Book ch. 9](https://doc.rust-lang.org/book/ch09-00-error-handling.html) · [RBE — Error handling](https://doc.rust-lang.org/rust-by-example/error.html)
> Companion: Rustlings error-handling, options
> Contribution target: Candle and opencv-rust both surface `Result`. A PR that `unwrap`s `VideoCapture` or `safetensors` will be rejected.
> Domain hook: missing weights, unreadable video, empty `Mat`, zero detections — all recoverable.

## Contract

No `unwrap` / `expect` in library paths.
`unwrap` in tests is allowed when the fixture is statically valid.
The tutor may show `?`.
The tutor may not design your error enum.

## Read first (do not skip)

- [ ] Book ch. 9 — panic vs `Result`, `?`, custom errors
- [ ] RBE error handling (unwrapping, `map`, `?`)
- [ ] Grep Candle for `pub type Result` / `candle_core::Error` (how they wrap)
- [ ] Grep opencv-rust examples for `.unwrap()` vs `?` — notice the FFI style, then do better in *your* API

## Why this exists

Lesson 12 will load RF-DETR weights (`safetensors` via `hf_hub` or a local path) and open a video (`opencv::videoio::VideoCapture` or a file of detections).
Both fail in boring ways.
This lesson makes those failures a type, not a crash.

## You write

Crate `lesson07` (or fold into the workspace):

```text
enum PipelineError { ... }
type Result<T> = std::result::Result<T, PipelineError>;
```

Required variants (names yours):

- source not found (video path or JSONL path)
- bad detection record (parse)
- empty frame (width or height 0)
- no weights (path or repo id)
- tracker invariant (duplicate track id)

Implement `Display` + `std::error::Error`.
Implement `From<std::io::Error>`.

Functions:

- `fn load_detections_jsonl(path: &Path) -> Result<Vec<Vec<Detection>>>` (one line per frame; invent a tiny format and document it)
- `fn require_frame(width: u32, height: u32) -> Result<()>`
- `fn load_weight_path(path: &Path) -> Result<()>` — existence check only; do not parse safetensors yet

Tests for each failure and one success path.
Use `tempfile` only if you add it deliberately and can justify it; otherwise write fixtures under `tests/data/`.

## Plan of work

### A. Read

- [ ] Rewrite a Book ch. 9 example with a custom error, not `Box<dyn Error>`

### B. Implement

- [ ] Error enum + `From`
- [ ] JSONL loader + fixtures
- [ ] `cargo test`
- [ ] clippy `-D warnings` (it will yell at leftover `unwrap`)

### C. Notes

- [ ] Copy *signatures only* of `Tensor::read_safetensors` or the Candle equivalent you found, and of `VideoCapture::from_file` / `is_opened`
- [ ] Write how *your* `PipelineError` would wrap each

## Definition of done

A missing file returns `Err`, never panic.
You can add a new variant without touching call sites that use `?`.

## Stretch

Read `thiserror` vs hand-written `Display`.
Do not add `thiserror` unless you can explain the expand.

## References

- https://doc.rust-lang.org/book/ch09-00-error-handling.html
- https://doc.rust-lang.org/rust-by-example/error.html
- https://github.com/huggingface/candle
- https://github.com/twistedfall/opencv-rust
- https://github.com/huggingface/safetensors
