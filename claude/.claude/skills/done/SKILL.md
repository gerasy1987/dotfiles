---
name: done
description: End-of-session review — extract learnings from the conversation and persist them to memory files and CLAUDE.md
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, Agent
---

# /done — Session Wrap-Up

Review this conversation from start to finish. Extract anything worth persisting for future sessions, then update memory and CLAUDE.md files accordingly.

## What to extract

Scan the conversation for:

1. **User preferences / feedback** — corrections to your approach, style preferences, workflow habits ("don't do X", "always do Y", "I prefer Z"). These are the highest-value memories.
2. **Project context** — decisions, goals, deadlines, architecture choices, stakeholder constraints that aren't obvious from the code alone.
3. **References** — pointers to external systems (Linear boards, Slack channels, dashboards, documentation URLs).
4. **User profile updates** — role, expertise, domain knowledge that should shape future interactions.

Do NOT extract:
- Things already in CLAUDE.md or existing memory files (read them first to check)
- Code patterns or architecture derivable from the codebase itself
- Ephemeral debugging details or one-off fixes
- Anything from this conversation that was purely mechanical (file reads, grep results, etc.)

## How to persist

### Step 1: Determine the memory directory

The memory directory is project-scoped. Find it by checking the `$CLAUDE_PROJECT_DIR` or by locating the nearest `.claude/` project config directory. The memory path follows the pattern:

```
~/.claude/projects/<project-key>/memory/
```

Read the existing `MEMORY.md` in that directory (if it exists) to understand what's already stored.

### Step 2: Create or update individual memory files

For each new piece of information worth saving, either **update an existing memory file** (if the topic overlaps) or **create a new one**.

Each memory file uses this format:

```markdown
---
name: <short descriptive name>
description: <one-line description — be specific so future relevance matching works>
type: <user | feedback | project | reference>
---

<content>
```

For `feedback` and `project` types, structure the content as:
- Lead with the rule or fact
- **Why:** the motivation or context
- **How to apply:** when/where this should shape behavior

File naming: use lowercase, hyphens, descriptive names like `feedback_no-trailing-summaries.md`, `user_role.md`, `project_merge-freeze.md`.

### Step 3: Update MEMORY.md index

`MEMORY.md` is an index only — it contains links to memory files with brief descriptions, not memory content itself. Keep it under 200 lines. Format:

```markdown
# MEMORY — <Project Name>

## User
- [user_role.md](user_role.md) — User's role and expertise

## Feedback
- [feedback_no-summaries.md](feedback_no-summaries.md) — Don't summarize at end of responses

## Project
- [project_auth-rewrite.md](project_auth-rewrite.md) — Auth middleware rewrite context
```

Group entries by type. Add new entries; do not remove existing ones unless they're clearly outdated (in which case, also delete the file).

### Step 4: Update CLAUDE.md (if warranted)

If this session produced learnings that should govern **all future Claude sessions in this project** (not just inform — govern), update the project's `CLAUDE.md`. Examples:
- Build/test commands that were discovered
- File editing rules specific to this codebase
- Conventions that aren't enforced by linters

Read the existing CLAUDE.md first. Only append to relevant sections — don't restructure or rewrite.

## Output

After updating files, print a brief summary:
- What memories were created/updated (with file paths)
- What was added to CLAUDE.md (if anything)
- A one-line summary of the session for the user's reference

If nothing from this session is worth persisting, say so — don't create empty or low-value memories.
