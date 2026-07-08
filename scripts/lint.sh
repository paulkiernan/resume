#!/bin/bash

set -eu

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)

# Match the version pinned in .github/workflows/superlinter.yaml
SUPER_LINTER_VERSION=v8.7.0

docker run \
    --rm \
    -e RUN_LOCAL=true \
    -e DEFAULT_BRANCH=main \
    -e VALIDATE_ALL_CODEBASE=true \
    -e VALIDATE_LATEX=true \
    -v "$REPO_ROOT_DIR":/tmp/lint \
    "ghcr.io/super-linter/super-linter:$SUPER_LINTER_VERSION"
