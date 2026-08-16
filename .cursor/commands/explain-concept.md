# Explain Concept

Explain one Rust concept in SuperGrok-tutor style.

## Usage

```
@explain-concept <concept>
```

Examples: `ownership`, `lifetimes`, `Result`, `dyn Trait`, `Pin`.

## Format

1. **What it is** - one paragraph
2. **Why Rust does this** - one paragraph
3. **Minimal example** - compiles with `cargo check`
4. **Common error** - real compiler message, then the fix
5. **Try this** - one exercise prompt, no full solution unless asked

## Constraints

- Stay on one concept
- No emoji
- No production refactors
- Cite `std` docs or The Book by name, not by dumping chapters
