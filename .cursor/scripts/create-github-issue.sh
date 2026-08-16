#!/bin/bash
# Create GitHub issue from ticket ID
# Usage: bash .cursor/scripts/create-github-issue.sh <ticket-id>

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
_SPRINT_PLAN={{ THE-SPRINT-PLAN-FILE }}
SPRINT_PLAN="$PROJECT_ROOT/$_SPRINT_PLAN"

# GitHub repository info
GITHUB_REPO={{ THE-GITHUB-REPO }}
GITHUB_BRANCH="main"

if [ -z "$1" ]; then
    echo "Usage: $0 <ticket-id>"
    echo "Example: $0 LESSON-001"
    exit 1
fi

TICKET_ID="$1"

# Extract ticket type for labeling (LESSON, RUST, FEAT, TEST, DOC)
TICKET_TYPE=$(echo "$TICKET_ID" | grep -oE '^(LESSON|RUST|FEAT|TEST|DOC)' | tr '[:upper:]' '[:lower:]')

if [ -z "$TICKET_TYPE" ]; then
    echo "Error: Invalid ticket ID format. Expected: LESSON-XXX, RUST-XXX, FEAT-XXX, TEST-XXX, or DOC-XXX"
    exit 1
fi

# Find plan file from sprint plan
PLAN_SLUG=$(grep -E "^\\| $TICKET_ID " "$SPRINT_PLAN" | awk -F'|' '{print $6}' | sed 's/^ *//;s/ *$//')

if [ -z "$PLAN_SLUG" ] || [ "$PLAN_SLUG" = "TBD" ]; then
    echo "Error: No plan file found for ticket $TICKET_ID"
    exit 1
fi

PLAN_FILE="$PROJECT_ROOT/.cursor/plans/${PLAN_SLUG}.plan.md"

if [ ! -f "$PLAN_FILE" ]; then
    echo "Error: Plan file not found: $PLAN_FILE"
    exit 1
fi

echo "Finding sprint epic issue..."
SPRINT_ISSUE_NUMBER=$(bash "$SCRIPT_DIR/get-sprint-issue.sh" "$SPRINT_PLAN")

if [ -z "$SPRINT_ISSUE_NUMBER" ]; then
    echo "Error: Failed to get sprint issue number"
    exit 1
fi

echo "Sprint epic: #$SPRINT_ISSUE_NUMBER"

DESCRIPTION=$(grep -m 1 '^overview:' "$PLAN_FILE" | sed 's/overview: *//')
PLAN_FILE_RELATIVE=".cursor/plans/${PLAN_SLUG}.plan.md"
PLAN_FILE_URL="https://github.com/${GITHUB_REPO}/blob/${GITHUB_BRANCH}/.cursor/plans/${PLAN_SLUG}.plan.md"
SPRINT_PLAN_URL="https://github.com/${GITHUB_REPO}/blob/${GITHUB_BRANCH}/.cursor/plans/$_SPRINT_PLAN"

DELIVERABLES=$(awk '/^## (Deliverables|Implementation Steps|Tasks)/, /^##/ {
    if ($0 ~ /^- /) print $0
}' "$PLAN_FILE" | head -10)

TODOS=$(awk '/^todos:/, /^[a-z_]+:/ {
    if ($0 ~ /content:/) {
        content=$0
        sub(/.*content: /, "", content)
        print "- [ ] " content
    }
}' "$PLAN_FILE")

echo "Creating GitHub issue for ticket: $TICKET_ID"
echo "Plan file: $PLAN_FILE_RELATIVE"
echo ""

TITLE="[$TICKET_ID] $DESCRIPTION"
if [ ${#TITLE} -gt 256 ]; then
    MAX_DESC_LEN=$((256 - ${#TICKET_ID} - 4))
    TITLE="[$TICKET_ID] $(echo "$DESCRIPTION" | cut -c1-$MAX_DESC_LEN)"
fi

ISSUE_BODY="Part of #${SPRINT_ISSUE_NUMBER}

## Plan File

[$PLAN_FILE_RELATIVE]($PLAN_FILE_URL)

## Description

$DESCRIPTION

## Deliverables

$DELIVERABLES

## Definition of Done

$TODOS

---

**Sprint Plan**: [$_SPRINT_PLAN]($SPRINT_PLAN_URL)
**Plan File**: [$PLAN_FILE_RELATIVE]($PLAN_FILE_URL)
"

gh issue create \
    --title "$TITLE" \
    --body "$ISSUE_BODY" \
    --label "cursor-plan,ticket,$TICKET_TYPE" \
    --assignee "@me"

echo ""
echo "PASS GitHub issue created successfully"
echo "PASS Ticket ID: $TICKET_ID"
