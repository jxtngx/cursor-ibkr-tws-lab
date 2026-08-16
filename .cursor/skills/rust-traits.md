# Skill: Rust Traits

Proficiency in traits, generics, and impl blocks.

## Competencies

- Define a trait for shared behavior, not for every type
- Use trait bounds and `where` clauses
- Know when `dyn Trait` is required
- Implement std traits (`Debug`, `Clone`, `From`, `Default`) deliberately

## Context

Traits are introduced after ownership and enums. Keep generic APIs readable.

## Checklist

- Trait is needed (not just a convenience inherent method)
- Bounds are minimal
- Object safety considered if using `dyn`
- rustdoc shows how to implement the trait
