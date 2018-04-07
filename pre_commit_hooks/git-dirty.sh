#!/bin/sh
set -eu

################################################################################
# Detect modified, added, and unstaged files.
# Respect overrides in .gitignore if present.
################################################################################

# GIT_INDEX_FILE is defined only when running as a git pre-commit hook.
# If run after commit, such as during CI, the variable is unset.
if [ "${GIT_INDEX_FILE:-unset}" = 'unset' ]; then
  output="$(git status --porcelain)"
  readonly output

  if [ -n "${output}" ]; then
    echo "${output}"
    exit 1
  fi
fi
