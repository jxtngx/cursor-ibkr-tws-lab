# Story Point Guidelines

Standard for estimating relative complexity using story points.

## Story Point Scale

Use Fibonacci: 1, 2, 3, 5, 8, 13

```mermaid
graph TD
    Task[Task] --> Simple{Simple?}
    Simple -->|Yes| OneTwo[1-2 points]
    Simple -->|No| Known{Well Understood?}
    Known -->|Yes| ThreeFive[3-5 points]
    Known -->|No| Large{Too Large?}
    Large -->|No| Eight[8 points]
    Large -->|Yes| Split[Split Story: 13+]
```

## Point Definitions

| Points | Complexity | Risk | Duration | Examples |
|--------|------------|------|----------|----------|
| 1 | Trivial | None | 1-2 hours | Add field to struct, fix typo |
| 2 | Simple | Low | Half day | Add validation, simple unit test |
| 3 | Moderate | Low | 1 day | Implement method with `Result` and tests |
| 5 | Complex | Medium | 2-3 days | New module with trait + impl |
| 8 | Very Complex | High | 4-5 days | Workspace refactor with tests |
| 13 | Too Large | - | Split | Epic-level work |

## Estimation Factors

Consider all dimensions:

1. **Technical Complexity**
   - Ownership and lifetime difficulty
   - Number of files touched
   - Trait and generic integration points

2. **Uncertainty**
   - New crate or nightly feature
   - Unknown dependencies
   - Ambiguous requirements

3. **Risk**
   - Breaking public API
   - unsafety or FFI
   - Performance implications

4. **Testing Effort**
   - Unit test coverage
   - Integration scenarios
   - Property / table-driven tests

## Reference Stories

Anchor estimates to these baseline stories:

```
1 point: Add `user_id` field to User struct
2 points: Write unit test for a parser helper
3 points: Implement a method returning Result with custom error
5 points: Add a new module with a trait, two impls, and rustdoc
8 points: Split a crate into a workspace with full test suite
```

## Estimation Rules

1. **Compare, Don't Calculate**: Relative to reference stories
2. **Whole Team Estimates**: Not individual assignments
3. **No Zero or Half Points**: Use defined scale only
4. **13 Means Split**: Break into smaller stories
5. **Re-estimate Only When**: Requirements change significantly

## Common Mistakes

| Mistake | Correction |
|---------|------------|
| Estimating in hours | Use story points for complexity |
| Considering who does it | Estimate for average team member |
| Padding estimates | Be honest, track velocity instead |
| Micro-precision | Use Fibonacci gaps, not 1,2,3,4,5,6... |
