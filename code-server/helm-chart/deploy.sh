#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git submodule update 


# Build the package.
helm package .  
helm repo index .
mv code-server-3.0.7.tgz ../../packages/code-server/
mv index.yaml ../../packages/code-server/

helm repo index ./code-server

# Go To Public folder, sub module commit
cd ../../packages

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin main

# Come Back up to the Project Root
cd ..

# charts 저장소 Commit & Push
git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg" 

git push --force origin main