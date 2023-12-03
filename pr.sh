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

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/pulls \
  -d '{"title":"Updated Solar System Image","body":"Updated deployment specification with a new image version.","head":"$HEAD_BRANCH","base":"$BASE_BRANCH"}'

# Check the exit status
if [ $? -eq 0 ]; then
  echo "Pull Request created successfully."
else
  echo "Failed to create Pull Request."
fi
