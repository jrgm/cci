#!/usr/bin/env sh

ls -lart --full-time
git rev-parse --short HEAD
git rev-parse --abbrev-ref HEAD
git log --format='%s' -1 | head -1 | perl -pe 's/%/%%/'
pwd
echo @@@
git checkout this-branch
git reset --hard origin/this-branch
git remote -v
git branch --set-upstream-to=origin/this-branch this-branch
git pull
npm i
ls -lart --full-time
git rev-parse --short HEAD
git rev-parse --abbrev-ref HEAD
git log --format='%s' -1 | head -1 | perl -pe 's/%/%%/'
