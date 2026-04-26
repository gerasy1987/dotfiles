#!/usr/bin/env bash
#
# Optional Phase 7 cleanup. Run manually when you want to reclaim disk.
# Does not affect tokens — purely disk-space hygiene.
#
# What it does (with --apply; otherwise dry-run):
#   1. Removes file-history dirs not modified in the last 30 days
#   2. Keeps the 10 most recent session-env snapshots, removes the rest
#   3. Lists PATHFINDER-* dirs in the claude-mem plugin cache (move manually if you want them archived)
#
# Usage:  ./disk-hygiene.sh           # dry run, shows what would be removed
#         ./disk-hygiene.sh --apply   # actually delete

set -euo pipefail

APPLY=0
[[ "${1:-}" == "--apply" ]] && APPLY=1

CLAUDE_HOME="${HOME}/.claude"

run() {
  if [[ $APPLY -eq 1 ]]; then "$@"; else echo "[dry-run] $*"; fi
}

echo "=== file-history dirs older than 30 days ==="
find "$CLAUDE_HOME/file-history" -mindepth 1 -maxdepth 1 -type d -mtime +30 -print0 | \
  while IFS= read -r -d '' d; do
    sz=$(du -sh "$d" | cut -f1)
    echo "  $d ($sz)"
    run rm -rf "$d"
  done

echo ""
echo "=== session-env snapshots (keeping 10 most recent) ==="
ls -1t "$CLAUDE_HOME/session-env" 2>/dev/null | tail -n +11 | while read -r f; do
  echo "  $CLAUDE_HOME/session-env/$f"
  run rm -rf "$CLAUDE_HOME/session-env/$f"
done

echo ""
echo "=== PATHFINDER transcript dirs in plugin cache (review and move manually) ==="
find "$CLAUDE_HOME/plugins/marketplaces/thedotmack" -maxdepth 2 -type d -name "PATHFINDER-*" 2>/dev/null | \
  while read -r d; do
    sz=$(du -sh "$d" | cut -f1)
    echo "  $d ($sz)  -> mv to ~/Documents/claude-mem-transcripts/ if you want to keep them"
  done

if [[ $APPLY -eq 0 ]]; then
  echo ""
  echo "Dry run complete. Re-run with --apply to actually delete."
fi
