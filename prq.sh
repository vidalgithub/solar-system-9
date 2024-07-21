#!/bin/bash

# GitHub repository details
REPO_OWNER="vidalgithub"
REPO_NAME="gitops-argocd"

# Branches for the pull request
BASE_BRANCH="main"
HEAD_BRANCH="feature"

# Pull request details
PR_TITLE="Update image"  #"Your Pull Request Title"
PR_BODY="Update image"  #"Description of your pull request"

# Create the pull request
gh pr create -R $REPO_OWNER/$REPO_NAME --base $BASE_BRANCH --head $HEAD_BRANCH --title "$PR_TITLE" --body "$PR_BODY"

echo "Pull Request created successfully."
