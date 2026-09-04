#!/bin/bash
# Lint the TeX sources with chktex.
#
# Runs anywhere chktex is installed: CI (apt), the resume-builder container
# (`task lint`), or a host TeX install such as TinyTeX (`task chktex`).
# chktex exits non-zero when it reports anything, so any finding fails the
# run. Silence a single false positive inline with `% chktex N`.

set -eu

cd "$(dirname "$0")/.."

# Prefer chktex on PATH; fall back to a local TinyTeX install.
CHKTEX=$(command -v chktex || echo "$HOME/Library/TinyTeX/bin/universal-darwin/chktex")

"$CHKTEX" -q tex/*.tex
