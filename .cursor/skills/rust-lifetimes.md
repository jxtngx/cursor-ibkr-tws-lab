# Skill: Rust Lifetimes

Proficiency in explicit and elided lifetimes.

## Competencies

- Explain why a reference needs a lifetime
- Use elision when the compiler already knows
- Annotate structs that store references
- Avoid `'static` as a panic button

## Context

Teach lifetimes after borrowing. Prefer redesigning ownership over adding annotations.

## Checklist

- Lifetime names are short and meaningful (`'a` on one source, `'src` if needed)
- Struct fields that borrow are documented
- No needless `'static`
- The API could not be simplified by taking ownership
