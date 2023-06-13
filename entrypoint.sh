#!/usr/bin/env ash
# shellcheck shell=dash

set -o nounset
set -o errexit
set -o pipefail

if [ $# -ne 1 ]; then
  echo "Requires one argument to run."
  exit 1
fi

# df
grep output /proc/mounts

# ls -l output

if [ "$1" = "write" ]; then
  echo "Hello, World!" > output/testing.txt
  redis-cli -h redis set test_output true
elif [ "$1" = "read" ]; then
  while [ "$(redis-cli -h redis get test_output)" != "true" ]; do
    sleep 5
  done
  cat output/testing.txt
  mv output/testing.txt output/testing-$(date +%Y-%m-%d_%H:%M:%S).txt
  redis-cli -h redis shutdown
fi

# ls -l output
