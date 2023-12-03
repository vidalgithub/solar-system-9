####################### GITEA ######################################

# echo "Opening a Pull Request"

# curl -X 'POST' \
#   'http://139.59.21.103:3000/api/v1/repos/siddharth/gitops-argocd/pulls' \
#   -H 'accept: application/json' \
#   -H "authorization: $ARGOCD_TOKEN" \
#   -H 'Content-Type: application/json' \
#   -d '{
#   "assignee": "siddharth",
#   "assignees": [
#     "siddharth"
#   ],
#   "base": "main",
#   "body": "Updated deployment specification with a new image version.",
#   "head": "feature-gitea",
#   "title": "Updated Solar System Image"
# }'

# echo "Success"

#############################################################################################################
# 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

# USE TOKEN TO SET REMOTE REPOSITORY URL IN THE LOCAL REPO.
# git remote set-url origin https://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@github.com/vidalgithub/<repo>


# 	1- COMMAND
# curl -L \
#   -X POST \
#   -H "Accept: application/vnd.github+json" \
#   -H "Authorization: Bearer <YOUR-TOKEN>" \
#   -H "X-GitHub-Api-Version: 2022-11-28" \
#   https://api.github.com/repos/OWNER/REPO/pulls \
#   -d '{"title":"Amazing new feature","body":"Please pull these awesome changes in!","head":"octocat:new-feature","base":"master"}'

# 	2- SCRIPT

#################################### GITHUB ###########################################################

#!/bin/bash

echo "Opening a Pull Request"
# Create PR
REPO_OWNER="vidalgithub"
REPO_NAME="gitops-argocd"
BASE_BRANCH="main"
HEAD_BRANCH="feature"
PR_TITLE="Updated Solar System Image"
PR_BODY="Updated deployment specification with a new image version."

GITHUB_TOKEN="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"

curl -L -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/pulls \
  -d '{
    "title": "'"$PR_TITLE"'",
    "body": "'"$PR_BODY"'",
    "head": "'"$REPO_OWNER:$HEAD_BRANCH"'",
    "base": "'"$BASE_BRANCH"'"
  }' \


# Assign PR to assignees = Update an issue
# https://docs.github.com/en/free-pro-team@latest/rest/issues/issues?apiVersion=2022-11-28#update-an-issue

PR_NUMBER=$(echo "$PR_RESPONSE" | jq -r '.number')

# Assuming you want to assign users "user1" and "user2"
# ASSIGN_USERNAMES=("user1" "user2")
ASSIGN_USERNAMES=("kemgou")

curl -L \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/OWNER/REPO/issues/ISSUE_NUMBER \
  -d '{"title":"Found a bug",
"body":"I'\''m having a problem with this.",
"assignees":['$(IFS=,; echo "${ASSIGN_USERNAMES[*]}")'],        
"milestone":1,
"state":"open",
"labels":["bug"]
}'

echo "Success"
