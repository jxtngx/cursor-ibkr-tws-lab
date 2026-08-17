# Start Lesson

Open the next Cursor Rust Lab lesson. Teach one official concept. Do not write the student's crate.

## Usage

```
@start-lesson [00-12 or slug]
```

If no number is given, pick the first `lessons/NN-*/LESSON.md` whose crate is missing or whose tests are not green.

## CRITICAL: Agent Must Not Implement

The agent MUST:

1. Open `lessons/NN-<slug>/LESSON.md`
2. Confirm **Read first** is underway (ask which Book sections they finished)
3. State the one official concept
4. Give a 10-20 line example of *the concept*, never the finished exercise
5. Show one common rustc error for that concept
6. Point at the **You write** section and stop

The agent MUST NOT:

- Run `cargo init` or create `src/` for them unless they are stuck on tooling and ask
- Implement ticks, `DOMLevel`, `OrderBook`, `Quoter`, `lob`, session filters, or an `ibapi` client
- Add `ibapi` / `prost`, connect to TWS, or submit an order
- Cover more than one major Book concept
- Replace the Book with a homemade lecture

## Sequence

See [lessons/README.md](../../lessons/README.md) and `.cursor/skills/curriculum-plan/SKILL.md`.

## Hand-off

Tell the student the exact `cargo init` line from the lesson, which test to write first, and that `@review-rust` comes only after `cargo test` is green.
