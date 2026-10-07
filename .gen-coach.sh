#!/usr/bin/env bash
#
# .gen-coach.sh — generate per-exercise solution patches from the MDKApp
# solution checkpoints.
#
# The MDKApp code repo is expected to carry one git tag per exercise checkpoint
# (see CHECKPOINTS below). For each exercise we take the diff between the
# previous checkpoint and this one, and write it to .coach/exN.diff — a raw patch,
# nothing else. Those patches are what the Cline coach reads on demand, in the
# final coaching stage (see setup/coach/clinerules/20-index.md, which also holds
# the short per-exercise summary + any caveats).
#
# This is the single source of truth for the solution diffs: never hand-edit
# .coach/exN.diff — change the code + tags in MDKApp and re-run this.
#
# Usage:
#   ./.gen-coach.sh [path-to-MDKApp-repo] [output-dir]
#
#   [path-to-MDKApp-repo]  Local clone of the MDK code repo that has the tags.
#                          Defaults to the repo this script lives in, so from
#                          inside the MDKApp clone you can just run ./.gen-coach.sh
#   [output-dir]           Where to write exN.diff (default: ./.coach next to
#                          this script).
#
# Example (from inside the MDKApp clone):
#   ./.gen-coach.sh

set -euo pipefail

# Ordered exercise checkpoints. Each entry is "exN:<tag>", oldest first.
# "base" is the starting state participants clone; exN is the solved state of
# exercise N. Adjust the tag names to match what you actually tag in MDKApp.
# ex1 has no code change (deploy + device onboarding only), so it has no
# checkpoint and no diff — base is the pre-ex2 state.
CHECKPOINTS=(
  "base:base"
  "ex2:ex2-solution"
  "ex3:ex3-solution"
  "ex4:ex4-solution"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="${1:-$SCRIPT_DIR}"
OUT_DIR="${2:-$SCRIPT_DIR/.coach}"

if [[ -z "$REPO" ]]; then
  echo "usage: $0 <path-to-MDKApp-repo> [output-dir]" >&2
  exit 2
fi
if [[ ! -d "$REPO/.git" ]]; then
  echo "error: '$REPO' is not a git repository (expected the MDKApp clone)" >&2
  exit 2
fi

mkdir -p "$OUT_DIR"

tag_exists() { git -C "$REPO" rev-parse -q --verify "refs/tags/$1" >/dev/null 2>&1; }

prev_tag=""
for entry in "${CHECKPOINTS[@]}"; do
  ex="${entry%%:*}"
  tag="${entry##*:}"

  # The "base" entry only sets the starting point; it has no coach file.
  if [[ "$ex" == "base" ]]; then
    if ! tag_exists "$tag"; then
      echo "warn: base tag '$tag' not found in MDKApp — skipping (diffs will be from the first available tag)" >&2
    else
      prev_tag="$tag"
    fi
    continue
  fi

  out="$OUT_DIR/$ex.diff"

  if ! tag_exists "$tag"; then
    echo "skip: tag '$tag' for $ex not found — leaving $ex.diff untouched" >&2
    # Do NOT advance prev_tag here: keep it pointing at the last checkpoint that
    # actually exists, so the next present tag still diffs from a valid ref
    # (e.g. a missing ex1-solution just means ex2 is diffed against base).
    continue
  fi

  if [[ -z "$prev_tag" ]]; then
    echo "skip: no previous checkpoint before $ex — cannot diff yet" >&2
    prev_tag="$tag"
    continue
  fi

  # Raw patch only. --ignore-all-space drops CRLF/whitespace noise (repos copied
  # between Windows and macOS otherwise show every file as changed). The
  # per-exercise summary + any caveats live in .clinerules/20-index.md, not here.
  echo "generating $out  ($prev_tag..$tag)"
  git -C "$REPO" diff --ignore-all-space "$prev_tag..$tag" > "$out"

  prev_tag="$tag"
done

echo "done. Coach files written to: $OUT_DIR"
