#!/usr/bin/env bash
set -euo pipefail

missing=0

while IFS= read -r file; do
  while IFS= read -r target; do
    [[ "$target" =~ ^https?:// ]] && continue
    [[ "$target" =~ ^# ]] && continue
    [[ "$target" =~ ^mailto: ]] && continue

    path="${target%%#*}"
    [[ -z "$path" ]] && continue

    if [[ "$path" = /* ]]; then
      candidate=".$path"
    else
      candidate="$(dirname "$file")/$path"
    fi

    if [[ ! -e "$candidate" ]]; then
      echo "Missing link target in $file: $target"
      missing=1
    fi
  done < <(grep -oE '\[[^]]+\]\(([^)]+)\)' "$file" | sed -E 's/.*\(([^)]+)\).*/\1/')
done < <(find . -path './.git' -prune -o -name '*.md' -type f -print)

exit "$missing"

