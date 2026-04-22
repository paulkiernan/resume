#!/bin/bash
# Thin wrapper kept for muscle memory; the build lives in Taskfile.yaml.

set -eux

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)

cd "$REPO_ROOT_DIR" && task build
