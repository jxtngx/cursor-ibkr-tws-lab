# SuperGrok Rust

Learn Rust with SuperGrok and Cursor.
This repo is a lab, not a product factory.
You read the official materials, you write the code, you sit with the compiler until it makes sense.
SuperGrok and Cursor are the tutor and the reviewer.
They are not allowed to do the work for you.

> **Audience.** You are a beginner who intends to become an advanced Rust user quickly.
> You have a [SuperGrok](https://grok.com) subscription and [Cursor](https://cursor.com) open on this repo.
> You will type every function yourself.
>
> **Bias.** Interaction over generation.
> The official tutorial over homemade curricula.
> Depth over a finished crate that you cannot explain.

This is the same contract as [cuda-spatial-intelligence-lab](https://github.com/jxtngx/cuda-spatial-intelligence-lab): a Cursor-native lab where the student does the work.
It is the opposite of [cursor-fullstack-template](https://github.com/jxtngx/cursor-fullstack-template) and [deep-learning-with-cursor](https://github.com/jxtngx/deep-learning-with-cursor), whose harnesses are built to implement tickets.
If an agent opens a PR with a complete solution you did not write, the lab failed.

---

## What this repo is

A thin Cursor harness around the official Learn Rust path.
The spine is [The Rust Programming Language](https://doc.rust-lang.org/book/) ("the Book").
[Rustlings](https://github.com/rust-lang/rustlings/) and [Rust by Example](https://doc.rust-lang.org/rust-by-example/) are the drills.
The [standard library](https://doc.rust-lang.org/std/), [Cargo Book](https://doc.rust-lang.org/cargo/), and later the [Rustonomicon](https://doc.rust-lang.org/nomicon/) are how beginners become advanced users without a side quest of blog posts.

What lives here:

- **`.cursor/agents/`** — tutor, engineer, test developer, architect, scrum master.
  The tutor explains one concept and leaves an exercise.
  The engineer and test developer review *your* code.
  None of them implement the lesson.
- **`.cursor/commands/`** — `@start-lesson`, `@explain-concept`, `@review-rust`, `@run-ticket-plan`.
  `@run-ticket-plan` shows the next ticket and stops.
  It must not write the code.
- **`.cursor/rules/`** — always-on: no emojis, incremental changes, rustfmt + clippy, `cargo test` is the source of truth, no `unwrap` in library paths, no clone-to-compile.
- **`.cursor/skills/`** — ownership, `Result`, traits, lifetimes, modules, Cargo.
  Skills are how the tutor stays aligned with the Book, not a substitute for reading it.
- **`lessons/`** — *your* crates, created as you work through chapters.
  Empty on purpose until you write them.

There is no multi-agent product pipeline here.
There is no "implement the sprint" loop.
If you want that, use the fullstack or deep-learning repos.

## How you are supposed to work

```
read the chapter  →  attempt the exercise  →  ask SuperGrok / Cursor  →  fix *your* code  →  cargo test
```

1. Read the Book chapter (or the matching Rustlings / Rust by Example section) *before* you prompt.
2. Write a failing test or a broken program yourself.
3. Ask SuperGrok or Cursor to explain the compiler error, not to paste the solution.
4. Change the code yourself.
5. Run `cargo test` and `cargo clippy --all-targets -- -D warnings`.
6. Only then use `@review-rust`.
   Review is a critique of your diff, not a rewrite.

### What the harness may do

- Point at the exact Book chapter, Rustlings exercise, or `std` item.
- Explain a compiler error in your words, then ask you what the ownership model is.
- Sketch a 10–20 line example of *the concept*, never the finished exercise.
- Review a diff you wrote and refuse clone-to-compile, hidden `unwrap`, and unexplained `unsafe`.

### What the harness must not do

- Implement `@run-ticket-plan` tickets.
- Fill in `lessons/` or `crates/` because you asked it to "just make it compile."
- Dump a complete crate, module, or test suite for an exercise you have not attempted.
- Skip ownership because it is annoying.
- Invent a parallel curriculum that replaces the Book.

If SuperGrok or Cursor starts writing the solution, stop it and ask for the question instead.

## Official spine

Do not replace these with a custom syllabus.
Lean on them in this order.

| Stage | Official material | You should be able to |
| --- | --- | --- |
| Start | [Install](https://www.rust-lang.org/learn/get-started) + Book ch. 1–3 | `rustup`, `cargo new`, scalars, control flow |
| Own it | Book ch. 4–6 + [Rustlings](https://github.com/rust-lang/rustlings/) | moves, borrows, structs, enums, `match` |
| Structure | Book ch. 7–11 | modules, collections, `Result`, traits, tests |
| Build | Book ch. 12–14 + [Cargo Book](https://doc.rust-lang.org/cargo/) | a real CLI, iterators, crates.io |
| Systems | Book ch. 15–20 | smart pointers, concurrency, patterns, a threaded server |
| Advanced | [std](https://doc.rust-lang.org/std/), [Reference](https://doc.rust-lang.org/reference/), [Nomicon](https://doc.rust-lang.org/nomicon/) | unsafe, aliasing, FFI, when *not* to reach for it |

Companion drills, used *with* the chapter, not instead of it:

- [Learn Rust](https://www.rust-lang.org/learn) — official index
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/) — short programs when the Book is too much prose
- [Compiler Error Index](https://doc.rust-lang.org/error-index.html) — every `E0xxx` you hit
- [Edition Guide](https://doc.rust-lang.org/edition-guide/) — this repo targets current stable / edition 2024

## Daily loop in Cursor

1. `@start-lesson [topic]` — the Rust Tutor names the one Book chapter, shows a tiny example, and leaves a test for *you* to make pass.
2. You write the code in `lessons/<topic>/`.
3. `@explain-concept <idea>` when you are stuck on *one* idea (ownership, `Result`, `'a`, `dyn Trait`).
4. `@review-rust` after `cargo test` is green.
   Fix what it flags yourself.
5. `@run-ticket-plan` only to see what is next.
   Then close the agent and write.

Keep SuperGrok in the same loop: ask it to quiz you, not to author the crate.
A useful prompt is "I read Book chapter N. Here is my code and the rustc error. Do not write the fix. Ask me three questions that force the right model."

## Tooling baseline

- **rustup** stable, current edition (2024).
- **cargo**, **rustfmt**, **clippy**, **rust-analyzer** in Cursor.
- **No extra crates** until the Book chapter you are on actually needs one.
  Prefer `std`.
- Open this repo in Cursor so `.cursor/` rules, agents, and commands load.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt clippy rust-analyzer
cargo --version
```

## Repo layout

```
.cursor/
  agents/      # tutor and reviewers — they do not implement
  commands/    # start-lesson, explain-concept, review-rust
  rules/       # always-on Rust and lab rules
  skills/      # Book-aligned concept notes
  plans/       # sprint plans, if you keep them
lessons/       # your chapter crates (you create these)
crates/        # shared code only after you can justify a public API
```

## Definition of done for a lesson

A lesson is done when *you* can do all of this without the model in the room:

- [ ] State the Book chapter and the one concept in a sentence
- [ ] Explain the last rustc error you hit and why the fix is the model, not a workaround
- [ ] `cargo test` and `cargo clippy --all-targets -- -D warnings` are clean
- [ ] No `unwrap` you cannot defend, no `clone` that exists to silence the borrow checker
- [ ] You can write the same program again from a blank file

If you cannot, you are not done, even if the tests pass because an agent wrote them.

## License

Apache-2.0. See [LICENSE](LICENSE).
