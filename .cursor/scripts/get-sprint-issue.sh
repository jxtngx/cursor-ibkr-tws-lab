#!/bin/bash
# Find or create the sprint epic issue for a sprint plan file.
# Usage: bash .cursor/scripts/get-sprint-issue.sh <path-to-sprint-plan>
# Prints the issue number to stdout.

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <path-to-sprint-plan>" >&2
    exit 1
fi

SPRINT_PLAN="$1"
PLAN_NAME=$(basename "$SPRINT_PLAN")

if [ ! -f "$SPRINT_PLAN" ]; then
    echo "Error: Sprint plan not found: $SPRINT_PLAN" >&2
    exit 1
fi

TITLE="Sprint: ${PLAN_NAME}"

EXISTING=$(gh issue list --search "in:title ${PLAN_NAME}" --json number,title --jq ".[] | select(.title==\"${TITLE}\") | .number" | head -1)

if [ -n "$EXISTING" ]; then
    echo "$EXISTING"
    exit 0
fi

BODY="Epic for ${PLAN_NAME}

Plan file: \`${PLAN_NAME}\`
"

ISSUE_URL=$(gh issue create --title "$TITLE" --body "$BODY" --label "cursor-plan,sprint")
ISSUE_NUMBER=$(echo "$ISSUE_URL" | grep -oE '[0-9]+$')

if [ -z "$ISSUE_NUMBER" ]; then
    echo "Error: Failed to create sprint epic issue" >&2
    exit 1
fi

echo "$ISSUE_NUMBER"
