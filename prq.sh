#!/bin/bash

# GitHub repository details
REPO_OWNER="vidalgithub"
REPO_NAME="your_repository"

# Branches for the pull request
BASE_BRANCH="main"
HEAD_BRANCH="feature"

# Pull request details
PR_TITLE="Your Pull Request Title"
PR_BODY="Description of your pull request"

# Create the pull request
gh pr create -R $REPO_OWNER/$REPO_NAME --base $BASE_BRANCH --head $HEAD_BRANCH --title "$PR_TITLE" --body "$PR_BODY"

echo "Pull Request created successfully."
