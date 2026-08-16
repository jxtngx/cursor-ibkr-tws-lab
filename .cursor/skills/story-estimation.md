# Story Estimation

Estimate task complexity using Planning Poker and story points.

## Planning Poker

```mermaid
graph LR
    Story[Present Story] --> Individual[Individual Estimate]
    Individual --> Reveal[Simultaneous Reveal]
    Reveal --> Discuss[Discuss Differences]
    Discuss --> Converge{Consensus?}
    Converge -->|No| Individual
    Converge -->|Yes| Record[Record Points]
```

## Estimation Factors

1. **Complexity**: Ownership, lifetimes, trait bounds
2. **Uncertainty**: New crate, unfamiliar API
3. **Effort**: Implementation plus rustdoc
4. **Risk**: Public API or lesson sequencing breakage

## Fibonacci Sequence

Use: 1, 2, 3, 5, 8, 13

Why: Forces meaningful distinctions, prevents false precision

## Reference Stories

| Points | Reference Example |
|--------|-------------------|
| 1 | Add field to an existing struct |
| 2 | Write a unit test for a helper |
| 3 | Implement a method returning `Result` |
| 5 | New module with a trait and two impls |
| 8 | Split a crate into a workspace with tests |

## Velocity Tracking

- **Measure**: Completed points per sprint
- **Calculate**: Rolling 3-sprint average
- **Adjust**: Update capacity planning
- **Trend**: Watch for consistent over/under estimation

## Anti-Patterns

Avoid:

- Estimating in hours (use story points)
- Comparing velocity across teams
- Using estimates for individual performance
- Re-estimating mid-sprint
