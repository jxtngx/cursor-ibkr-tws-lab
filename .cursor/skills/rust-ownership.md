# Skill: Rust Ownership

Proficiency in teaching and applying Rust ownership, moves, and borrows.

## Competencies

- Distinguish move, copy, and borrow
- Choose `&T` vs `&mut T` vs owned `T`
- Avoid clone-to-compile
- Read borrow-checker errors and fix the model, not the symptom

## Context

Ownership is the core Cursor IBKR TWS Lab lesson. Every API and exercise starts here.

## Checklist

- Values have one owner
- Borrows do not outlive the owner
- Mutation is exclusive
- `Copy` types are explicit and cheap
- Returned references have a visible lifetime source
