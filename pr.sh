#!/bin/bash

# GitHub repository details
REPO_OWNER="vidalgithub"
REPO_NAME="gitops-argocd"

# Branches for the pull request
BASE_BRANCH="main"
HEAD_BRANCH="feature"

# Pull request details
PR_TITLE="Updated Solar System Image by Kemgou"
PR_BODY="Updated deployment specification with a new image version."

# Create the pull request
gh pr create -R $REPO_OWNER/$REPO_NAME --base $BASE_BRANCH --head $HEAD_BRANCH --title "$PR_TITLE" --body "$PR_BODY"

# Check the exit status
if [ $? -eq 0 ]; then
  echo "Pull Request created successfully."
else
  echo "Failed to create Pull Request."
fi
