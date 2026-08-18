# Agent Tools Reference

How Cursor IBKR TWS Lab Cursor agents work together.

```mermaid
graph TD
    User[User / SuperGrok] --> SM[Scrum Master]
    User --> Tutor[Rust Tutor]
    SM --> CA[Chief Architect]
    CA --> Tutor
    CA --> RE[Rust Engineer]
    CA --> TD[Test Developer]
    Tutor --> Lessons[lessons/]
    RE --> Crates[crates/]
    TD --> Tests[tests/ + CI]
```

## When to use which agent

| Need | Agent |
|------|-------|
| Learn a concept | Rust Tutor |
| Write crate API | Rust Engineer |
| Add tests / CI | Test Developer |
| Sequence work | Scrum Master |
| Approve design | Chief Architect |

## Commands

| Command | Purpose |
|---------|---------|
| `@start-lesson` | Open the next lesson crate |
| `@explain-concept` | Teach one idea |
| `@review-rust` | Idiomatic review of the diff |
| `@run-ticket-plan` | Show the next ticket, do not implement |
| `@configure-github-issue-script` | Wire issue creation to a sprint plan |

## Ticket prefixes

`LESSON`, `RUST`, `FEAT`, `TEST`, `DOC`
