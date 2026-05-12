#!/usr/bin/env bash
set -euo pipefail
MODE="${1:-all}"; [ "${1:-}" = "--mode" ] && MODE="${2:-all}"
mkdir -p artifacts/logs
EXIT=0
HTML_FILES=$(find . -maxdepth 3 -name '*.html' -not -path './.git/*')
echo "[discover] HTML pages: $(echo "$HTML_FILES" | wc -l)"
echo "[verify] sitemap urls: $(grep -c '<url>' sitemap.xml 2>/dev/null || echo 0)"
while read f; do
  [ -z "$f" ] && continue
  for t in $(grep -oE "(href=\"|location\.href=')(blog|products)/[a-z0-9_-]+\.html" "$f" 2>/dev/null | sed -E "s/.*(blog|products)\//\1\//"); do
    [ -f "$t" ] || { echo "  MISSING $f -> $t"; EXIT=1; }
  done
done <<< "$HTML_FILES"
echo "exit=$EXIT"
exit $EXIT
