#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

changed_count="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
echo "[hooks][post-tool-use] tracked changes: $changed_count"

if [[ -f ".github/scripts/pre-tool-use.sh" && -f ".github/scripts/post-tool-use.sh" ]]; then
  echo "[hooks][post-tool-use] hook scripts present"
else
  echo "[hooks][post-tool-use] warning: one or more hook scripts are missing"
fi

exit 0
