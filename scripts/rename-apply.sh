#!/usr/bin/env bash
# Mechanical Derrick → Derrick rename for derrick-plugin-sdk.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

git switch -c main 2>/dev/null || git checkout -b main 2>/dev/null || true

replace_in_files() {
  local pattern="$1"
  local replacement="$2"
  shift 2
  if [[ "$#" -eq 0 ]]; then
    find . -type f \
      ! -path './.git/*' \
      -print0 | xargs -0 sed -i '' -e "s|${pattern}|${replacement}|g"
  else
    find "$@" -type f -print0 | xargs -0 sed -i '' -e "s|${pattern}|${replacement}|g"
  fi
}

# Module path
replace_in_files 'github.com/nomatronio/derrick-plugin-sdk' 'github.com/nomatronio/derrick-plugin-sdk'

# Proto package (plugin SDK uses nomatron.derrick.plugin)
replace_in_files 'hashicorp\.derrick\.plugin' 'nomatron.derrick.plugin'
replace_in_files 'nomatron/derrick/plugin' 'nomatron/derrick/plugin'

# Product strings
replace_in_files 'Derrick Plugin SDK' 'Derrick Plugin SDK'
replace_in_files 'Derrick plugin' 'Derrick plugin'
replace_in_files 'derrick plugin' 'derrick plugin'
replace_in_files 'Derrick' 'Derrick'
replace_in_files 'derrick' 'derrick'

echo "derrick-plugin-sdk rename complete."
