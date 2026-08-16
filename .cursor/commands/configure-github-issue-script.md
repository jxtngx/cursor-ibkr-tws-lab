# Configure GitHub Issue Script

Configure `.cursor/scripts/create-github-issue.sh` for this repository.

## Purpose

After the first sprint plan exists, set the script placeholders so tickets can become GitHub issues.

## Configuration Variables

1. **_SPRINT_PLAN** : path to the sprint plan file
2. **GITHUB_REPO** : `jxtngx/cursor-rust-lab`

## Implementation Steps

### 1. Gather Information

Ask user for:

**Sprint Plan File Name**:
- Suggest: `cursor-rust-lab-sprint.plan.md`
- Location: `.cursor/plans/` or `.cursor/plans/project-init/`
- Must end with `.plan.md` and use kebab-case

**GitHub Repository** (default):
- `jxtngx/cursor-rust-lab`

### 2. Update create-github-issue.sh

Replace:

```
_SPRINT_PLAN={{ THE-SPRINT-PLAN-FILE }}
GITHUB_REPO={{ THE-GITHUB-REPO }}
```

with the confirmed values.

### 3. Verify

Show the updated lines. Usage:

```bash
bash .cursor/scripts/create-github-issue.sh LESSON-001
```

Ticket prefixes: `LESSON`, `RUST`, `FEAT`, `TEST`, `DOC`.
