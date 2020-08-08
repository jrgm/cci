#!/usr/bin/env sh

set -x

CONTENT_SERVER_DOMAIN="${1:-accounts.stage.mozaws.net}"

# This script is called from a circleci job that uses {restore,save}_cache
# to cache the previously __version__ sha. Note: the $PREVIOUS_SHA_FILE name
# must match the path specified in save_cache of the calling job.
PREVIOUS_SHA=""
PREVIOUS_SHA_FILE="./v1-previous-fxa-content-version-commit-sha.txt"
if [ -f "${PREVIOUS_SHA_FILE}" ]; then
  PREVIOUS_SHA=$(cat "${PREVIOUS_SHA_FILE}")
fi

COMMIT_SHA=$(curl -s https://${CONTENT_SERVER_DOMAIN}/__version__ | perl -ne 'next unless /"commit":\s+"([^"]*)"/; print $1, $/')
echo current: "${COMMIT_SHA}" previous: "${PREVIOUS_SHA}"

if [ -z "${COMMIT_SHA}" ]; then
  # if no parseable response, bail out
  echo if no parseable response, bail out
  exit 0
fi

if [ "${COMMIT_SHA}" = "${PREVIOUS_SHA}" ]; then
  # run the test
  echo run the test
  exit 0
else 
  echo skip the test
  exit 0
fi

# save the current sha to the cached file path
/bin/echo -n $COMMIT_SHA > "${PREVIOUS_SHA_FILE}"

