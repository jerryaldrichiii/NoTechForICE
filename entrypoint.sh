#!/bin/sh
set -eu

# ---- Required environment variables ----
: "${GITHUB_USER_EMAIL:?Must set GITHUB_USER_EMAIL}"
: "${GITHUB_REPO:?Must set GITHUB_REPO (EXAMPLE: git@github.com:yourusernaem/NoTechForICE.git)}"

WORKDIR=/app
cd "$WORKDIR"

# If you read this in the output and are surprised...you deserve it
echo "Replacing current git repo (THIS IS DESTRUCTIVE!)"
rm -rf .git
git init

git config --global user.name "NoTechForICE"
git config --global user.email "$GITHUB_USER_EMAIL"

# Prevent "dubious ownership" errors on bind mounts
git config --global --add safe.directory "$WORKDIR"

git add .
git commit -vm "#NoTechForICE"

echo "Running github-spray"
github-spray --file "NoTechForICE.json"

echo "Replacing .git directory"
rm -rf .git
mv spray-*/.git .
rm -rf spray-*

git add .
git commit -asvm "#NoTechForICE"

# The hash below is the same for all repos, not need to update
echo "Rewriting commit messages"
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch \
  -f \
  --msg-filter "sed 's/github-spray/#NoTechForICE/'" \
  4b825dc642cb6eb9a060e54bf8d69288fbee4904..HEAD

echo "Adding remote and force-pushing"
git remote add origin "$GITHUB_REPO"

# Sorry, github-spray is old and thus it uses master not main
git push origin master -f

echo "Done"

