#!/bin/bash

set -eux

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)

docker build -t resume-builder "$REPO_ROOT_DIR"

docker run \
    --rm \
    -v "$REPO_ROOT_DIR:/src" \
    -it resume-builder:latest \
        make all && mv resume.pdf pdf/latest.pdf
