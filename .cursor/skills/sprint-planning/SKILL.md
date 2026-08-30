---
name: sprint-planning
description: "Sprint Planning. Break curriculum epics into sprint-sized lessons and tickets. Use when this role or topic is in scope."
---

# Sprint Planning

Break curriculum epics into sprint-sized lessons and tickets.

## Process

1. **Review Backlog**: Understand lesson order and dependencies
2. **Estimate Capacity**: Calculate team velocity and availability
3. **Break Down Work**: Split large topics into implementable chunks
4. **Define Done**: Set measurable acceptance criteria
5. **Commit**: Team agrees to sprint goal

## Task Breakdown

```mermaid
graph TD
    Epic[Curriculum Epic] --> Stories[Lessons / Stories]
    Stories --> Tasks[Technical Tasks]
    Tasks --> Points[Story Points]
    Points --> Capacity{Fits Sprint?}
    Capacity -->|Yes| Commit[Sprint Backlog]
    Capacity -->|No| Split[Split or Defer]
```

## Acceptance Criteria Template

```
Given [context]
When [action]
Then [expected result]
```

## Capacity Planning

- **Velocity**: Average story points from last 3 sprints
- **Availability**: Account for PTO, holidays, meetings
- **Buffer**: Reserve 20% for unplanned work

## Story Point Guidelines

| Points | Complexity | Duration |
|--------|------------|----------|
| 1 | Trivial | < 2 hours |
| 2 | Simple | Half day |
| 3 | Moderate | 1 day |
| 5 | Complex | 2-3 days |
| 8 | Very Complex | 1 week |
| 13 | Too Large | Split required |

## Sprint Goal

Every sprint must have ONE clear goal:

- Measurable outcome
- Adds learner or crate value
- Achievable within sprint
- Aligned with the Rust curriculum
