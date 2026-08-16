# Lesson Plan Template

Copy to `.cursor/plans/<slug>.plan.md`.

```markdown
---
name: LESSON-000 topic name
overview: One-line description of the concept
todos:
  - id: explain
    content: Explain the concept with a minimal example
    status: pending
  - id: exercise
    content: Add a cargo test exercise
    status: pending
  - id: recap
    content: Write a three-bullet recap
    status: pending
---

# LESSON-000: Topic

## Goal End State

Learner can explain the concept and make the exercise tests pass.

## Concept

One paragraph.

## Example

Minimal compiling example (described, not implemented here).

## Exercise

Given [setup]
When [action]
Then [assertion]

## Constraints

- One concept only
- No unwrap in the solution unless called out
- Stay in lessons/<topic>/

## Agent

Rust Tutor
```
