#!/usr/bin/env sh

ls -lart --full-time
git rev-parse --short HEAD
git rev-parse --abbrev-ref HEAD
git log --format='%s' -1 | head -1 | perl -pe 's/%/%%/'
pwd
echo @@@
git checkout master
git reset --hard origin/master
git remote -v
git pull
ls -lart --full-time
git rev-parse --short HEAD
git rev-parse --abbrev-ref HEAD
git log --format='%s' -1 | head -1 | perl -pe 's/%/%%/'
