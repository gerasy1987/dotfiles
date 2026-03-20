#!/bin/bash
#
# PreToolUse hook for Read: intercepts PDF reads, converts to cached text,
# and redirects Claude to read the text version instead.
#
# Uses pdftotext (from poppler) for high-fidelity text extraction.
# Caches converted files in /tmp/claude-pdf-cache/ keyed by file hash.

set -euo pipefail

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only intercept .pdf files
if [[ ! "$FILE_PATH" == *.pdf && ! "$FILE_PATH" == *.PDF ]]; then
  exit 0
fi

# Verify the PDF exists
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0  # Let Read handle the "file not found" error naturally
fi

CACHE_DIR="/tmp/claude-pdf-cache"
mkdir -p "$CACHE_DIR"

# Cache key: hash of absolute path + file modification time for invalidation
ABS_PATH=$(cd "$(dirname "$FILE_PATH")" && pwd)/$(basename "$FILE_PATH")
MOD_TIME=$(stat -f '%m' "$ABS_PATH" 2>/dev/null || stat -c '%Y' "$ABS_PATH" 2>/dev/null || echo "0")
CACHE_KEY=$(echo "${ABS_PATH}:${MOD_TIME}" | shasum -a 256 | cut -d' ' -f1)
CACHED_TEXT="${CACHE_DIR}/${CACHE_KEY}.txt"

# Convert if not already cached
if [[ ! -f "$CACHED_TEXT" ]]; then
  if ! pdftotext -layout "$ABS_PATH" "$CACHED_TEXT" 2>/dev/null; then
    # Conversion failed — fall back to letting Read handle the PDF natively
    rm -f "$CACHED_TEXT"
    exit 0
  fi
fi

LINE_COUNT=$(wc -l < "$CACHED_TEXT" | tr -d ' ')
BASENAME=$(basename "$FILE_PATH")

# Redirect the Read to the cached text file
cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "updatedInput": {
      "file_path": "${CACHED_TEXT}"
    },
    "additionalContext": "PDF auto-converted to text via pdftotext. Original: ${ABS_PATH} (${LINE_COUNT} lines). The cached text file is at ${CACHED_TEXT}. You can also Grep this file or the cache dir ${CACHE_DIR}/ to search across converted PDFs. For page-specific extraction, run: pdftotext -f <first> -l <last> '${ABS_PATH}' -"
  }
}
EOF
exit 0
