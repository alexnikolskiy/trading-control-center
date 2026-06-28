#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
parent="$(dirname "$root")"

repos=(
  trading-platform
  trading-platform-sdk
  trading-lab
  trading-office
  trading-backtester
  trading-mock-platform
)

for repo in "${repos[@]}"; do
  path="$parent/$repo"
  if [[ ! -d "$path/.git" ]]; then
    printf '%-24s %s\n' "$repo" "not found at $path"
    continue
  fi

  branch="$(git -C "$path" branch --show-current)"
  status="$(git -C "$path" status --short | wc -l | tr -d ' ')"
  printf '%-24s branch=%-24s changed_files=%s\n' "$repo" "${branch:-detached}" "$status"
done

