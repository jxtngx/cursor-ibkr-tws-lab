# Run Ticket Plan

Verify git state, check sprint progress, and display the next ticket to work on.

## Usage

```
@run-ticket-plan
```

## CRITICAL: Agent Must Not Implement

The agent MUST NOT:

- Implement any code changes from the ticket plan
- Edit any source files
- Update sprint plan status
- Move completed plans
- Run extra git commands beyond checkout/pull/branch
- Create commits

The agent's role is ONLY to:

- Verify git state
- Identify next ticket
- Create the branch
- Display the ticket plan link

The user will implement the ticket plan themselves.

## Workflow

1. Check git: `git checkout main && git pull origin main`
2. Find the active sprint plan under `.cursor/plans/`
3. Find last ticket with `status: completed`
4. Ask user: "Is [TICKET-ID] the last ticket you completed?"
5. If yes: Display next pending ticket plan path
6. If no: Ask which ticket was last, then display next

## Ticket Types

| Prefix | Owner |
|--------|-------|
| `LESSON-` | Rust Tutor |
| `RUST-` / `FEAT-` | Rust Engineer |
| `TEST-` | Test Developer |
| `DOC-` | Tutor or Engineer |

## Implementation Steps

1. Run: `git checkout main && git pull origin main`
2. Read the active sprint plan frontmatter
3. Parse todos, find last with `status: completed`
4. Ask user: "Last completed: TICKET-ID. Correct?"
5. If confirmed: find next pending ticket in sequence
6. Display: "Next ticket: TICKET-ID"
7. Display: "Plan file: @.cursor/plans/[ticket-plan-file].plan.md"
8. Create branch: `git checkout -b {ticket-type}/{TICKET-ID-description}`
9. Display GitHub issue link if present
10. **STOP HERE - hand off to user**
