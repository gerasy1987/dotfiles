#!/usr/bin/env bash
#
# Stop hook: deterministic replacement for the prior `type: "prompt"` LLM check.
# Walks the session transcript for the most recent turn (since last user prompt).
# Blocks only when Claude wrote/edited a .tex/.qmd/.R/.svg file in this turn
# without subsequently invoking a compile/render command.
#
# Replaces the previous LLM-prompt hook (~80 prompt tokens + 1 model round-trip per Stop).

set -euo pipefail

INPUT=$(cat)

exec python3 - "$INPUT" <<'PY'
import json, re, sys

payload = json.loads(sys.argv[1])
transcript = payload.get("transcript_path")
if not transcript:
    print(json.dumps({}))  # nothing to check
    sys.exit(0)

RISKY_EDIT_TOOLS = {"Write", "Edit", "MultiEdit", "NotebookEdit"}
RISKY_PATH = re.compile(r"\.(tex|qmd|R|svg)$", re.IGNORECASE)
VERIFY_RX = re.compile(
    r"\b(xelatex|latexmk|pdflatex|lualatex|Rscript|pdf2svg|rsvg-convert)\b|quarto\s+render",
    re.IGNORECASE,
)

try:
    with open(transcript) as f:
        entries = [json.loads(l) for l in f if l.strip()]
except (OSError, json.JSONDecodeError):
    print(json.dumps({}))
    sys.exit(0)

# Walk backward; collect assistant tool_use items until we hit the most recent
# real user message (not a tool_result-bearing user entry).
risky_edits = []
verify_calls = 0
for e in reversed(entries):
    t = e.get("type")
    if t == "user":
        msg = e.get("message", {})
        content = msg.get("content") if isinstance(msg, dict) else None
        # A tool_result-bearing user entry is part of the same turn; keep walking.
        if isinstance(content, list) and any(
            isinstance(c, dict) and c.get("type") == "tool_result" for c in content
        ):
            continue
        # Real user prompt -> turn boundary.
        break
    if t != "assistant":
        continue
    msg = e.get("message", {})
    if not isinstance(msg, dict):
        continue
    content = msg.get("content")
    if not isinstance(content, list):
        continue
    for c in content:
        if not (isinstance(c, dict) and c.get("type") == "tool_use"):
            continue
        name = c.get("name", "")
        inp = c.get("input", {}) or {}
        if name in RISKY_EDIT_TOOLS:
            path = inp.get("file_path") or inp.get("notebook_path") or ""
            if RISKY_PATH.search(path):
                risky_edits.append(path)
        elif name == "Bash":
            cmd = inp.get("command", "")
            if VERIFY_RX.search(cmd):
                verify_calls += 1

if risky_edits and verify_calls == 0:
    files = ", ".join(sorted(set(risky_edits))[:5])
    print(json.dumps({
        "decision": "block",
        "reason": f"Verify: compile/render the modified files ({files}).",
    }))
else:
    print(json.dumps({}))
PY
