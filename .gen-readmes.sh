#!/usr/bin/env bash
#
# .gen-readmes.sh — sync the exercise README *text* into .coach/exN.md so the
# in-workshop coach can read the exact low-code steps on demand (the .coach/exN.diff
# only carries the end result, not the Page-Editor method).
#
# Source of truth is the AD265 instructions repo (the "2026TechEd" repo). Images
# are stripped — the coach only needs the text. Hidden (leading-dot) name + output
# inside the hidden .coach/ folder so the MDK bundler skips them on deploy.
#
# Do NOT hand-edit .coach/exN.md — change the README in the instructions repo and
# re-run this.
#
# Usage:
#   ./.gen-readmes.sh [path-to-2026TechEd-repo]
#   (defaults to the parent folder of this repo, which is where the instructions
#    repo sits in the maintainer's local layout)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TECHED="${1:-$SCRIPT_DIR/..}"
SRC="$TECHED/ad265/exercises"
OUT="$SCRIPT_DIR/.coach"

if [[ ! -d "$SRC" ]]; then
  echo "error: no exercises found at '$SRC'" >&2
  echo "       pass the path to the 2026TechEd instructions repo:" >&2
  echo "       ./.gen-readmes.sh /path/to/2026TechEd" >&2
  exit 2
fi

mkdir -p "$OUT"
shopt -s nullglob

for dir in "$SRC"/ex*/; do
  ex="$(basename "$dir")"
  readme="$dir/README.md"
  [[ -f "$readme" ]] || continue
  {
    echo "<!-- Generated from the AD265 instructions repo ($ex/README.md); images stripped. Do not hand-edit — re-run .gen-readmes.sh. -->"
    echo
    # strip markdown images ![alt](path) and HTML <img ...> tags; keep all other text
    perl -0pe 's/!\[[^\]]*\]\([^)]*\)//g; s/<img\b[^>]*>//g' "$readme"
  } > "$OUT/$ex.md"
  echo "wrote $OUT/$ex.md  (from $ex/README.md)"
done

echo "done. Exercise instructions written to: $OUT"
