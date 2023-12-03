#!/bin/bash

echo "Opening a Pull Request"
# Create PR
REPO_OWNER="john"
REPO_NAME="gitops-argocd"
BASE_BRANCH="main"
HEAD_BRANCH="feature"
PR_TITLE="Updated Solar System Image"
PR_BODY="Updated deployment specification with a new image version."

GITHUB_TOKEN="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"

PR_RESPONSE=$(curl -L -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/pulls \
  -d '{
    "title": "'"$PR_TITLE"'",
    "body": "'"$PR_BODY"'",
    "head": "'"$REPO_OWNER:$HEAD_BRANCH"'",
    "base": "'"$BASE_BRANCH"'"
  }')

# Extract PR number from the response
PR_NUMBER=$(echo "$PR_RESPONSE" | jq -r '.number')

# Assuming you want to assign users "user1" and "user2"
ASSIGN_USERNAMES=("kemgou")

# Replace placeholders with actual values in the URL
ISSUE_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/issues/$PR_NUMBER"

curl -L -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  $ISSUE_URL \
  -d '{
    "title": "Found a bug",
    "body": "I'\''m having a problem with this.",
    "assignees": ['$(IFS=,; echo "${ASSIGN_USERNAMES[*]}")'],
    "milestone": 1,
    "state": "open",
    "labels": ["bug"]
  }'

echo "Success"
