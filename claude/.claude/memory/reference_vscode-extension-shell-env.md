---
name: vscode-extension-shell-env
description: Shells spawned by the Claude Code VS Code extension carry ELECTRON_RUN_AS_NODE=1, so launching any Electron app (code, positron, AppImages) from them fails with "bad option"; unset it first, and check env propagation by spawning a process rather than reading /proc/<pid>/environ
type: reference
---

When Claude Code runs inside the VS Code extension, its shell inherits `ELECTRON_RUN_AS_NODE=1` (the extension starts the CLI through VS Code's bundled Node). Any Electron binary started from that shell then parses its arguments as Node options and dies with `bad option: --user-data-dir=...` or similar.

**Why:** On 2026-10-13 a throwaway Positron launch for testing failed this way until it was run through `env -u ELECTRON_RUN_AS_NODE -u VSCODE_IPC_HOOK_CLI <binary>`. The `/usr/bin/code` and `/usr/bin/positron` wrapper scripts set the variable themselves for their own CLI, so `code --install-extension` keeps working; only direct launches of Electron executables break.

**How to apply:** Prefix direct Electron launches with `env -u ELECTRON_RUN_AS_NODE`. Electron main processes are non-dumpable, so `/proc/<pid>/environ` reads back empty even for your own user; to confirm an environment variable reaches apps, spawn `env` through the launcher under test (for Hyprland: `hyprctl dispatch 'hl.dsp.exec_cmd("sh -c \"env > /path\"")'`) instead.
