# Personal Dotfiles Repository

GNU Stow-based dotfiles for Arch Linux with Hyprland (Wayland compositor).

## Repository Structure

Each top-level folder is a **stow package** that mirrors the target directory structure relative to `$HOME`. Running `stow <package>` symlinks its contents to `~`.

```
dotfiles/
├── fish/.config/fish/          # Fish shell config
├── hypr/.config/hypr/          # Hyprland, hypridle, hyprpaper
├── waybar/.config/waybar/      # Status bar
├── foot/.config/foot/          # Terminal emulator
├── starship/.config/starship/  # Prompt
├── rofi/.config/rofi/          # App launcher
├── mako/.config/mako/          # Notifications
├── btop/.config/btop/          # System monitor
├── cava/.config/cava/          # Audio visualizer
├── kanshi/.config/kanshi/      # Display management
├── claude/.claude/             # Claude Code configuration
└── ...
```

## Usage

```bash
cd ~/dotfiles
stow fish foot starship  # Install selected packages
stow -D fish             # Uninstall a package
stow -R fish             # Restow (uninstall + install)
```

## Key Applications

| Package | Purpose |
|---------|---------|
| `hypr` | Hyprland compositor, idle daemon, wallpaper |
| `fish` | Shell with syntax highlighting and autosuggestions |
| `waybar` | Customizable status bar with modules |
| `foot` | Fast, minimal Wayland terminal |
| `rofi` | Application launcher and dmenu replacement |
| `mako` | Lightweight notification daemon |
| `kanshi` | Automatic display configuration |

## Claude Code Configuration

The `claude/` package contains Claude Code CLI settings, synced via stow to `~/.claude/`.

### Structure

```
claude/.claude/
├── agents/        # Custom review agents
├── rules/         # Global rules (applied to all projects)
├── skills/        # Reusable slash commands
└── settings.json  # Permissions and hooks
```

### Agents

Specialized subagents for code review and quality checks:

| Agent | Purpose |
|-------|---------|
| `slide-auditor` | Visual layout checks for RevealJS/Beamer slides |
| `proofreader` | Grammar, typos, overflow detection |
| `quarto-critic` | Compares Quarto HTML against Beamer PDF |
| `r-reviewer` | R code quality and reproducibility |
| `tikz-reviewer` | TikZ diagram positioning and aesthetics |
| `domain-reviewer` | Subject-matter accuracy checks |
| `pedagogy-reviewer` | Teaching flow and clarity |

### Rules

Global instructions applied to every Claude Code session:

- `plan-first-workflow.md` - Require planning before implementation
- `orchestrator-protocol.md` - Autonomous implement→verify→review→fix loop
- `quality-gates.md` - Minimum quality thresholds
- `verification-protocol.md` - Compile/render verification requirements

### Skills

Slash commands invoked with `/skill-name`:

| Skill | Purpose |
|-------|---------|
| `/compile-latex` | XeLaTeX compilation with bibtex |
| `/translate-to-quarto` | Convert Beamer to RevealJS |
| `/proofread` | Run proofreader agent |
| `/slide-excellence` | Full slide quality review |
| `/deploy` | Sync to docs/ for GitHub Pages |

### Excluded from Git

These files remain local (not synced):

- `.credentials.json` - Auth tokens
- `settings.local.json` - Session-specific permissions
- `history.jsonl` - Conversation history
- `projects/` - Project-specific rules
- `cache/`, `todos/`, `session-env/` - Transient state

## Adding New Packages

1. Create folder: `mkdir -p newpkg/.config/newpkg`
2. Add config files mirroring target paths
3. Stow: `stow newpkg`

## Branches and Machines

- `main` targets the Arch Linux laptop (Intel iGPU + NVIDIA).
- `asahi` targets the MacBook on Fedora Asahi Remix (aarch64).
- Hardware- and path-specific lines (`AQ_DRM_DEVICES`, `LIBVA_DRIVER_NAME`, the polkit agent path) differ between machines. Comment them out on the other branch rather than deleting them.
- The repo is edited from both machines, so run `git fetch && git status -sb` and fast-forward **before** editing anything.
- The VS Code settings in `vscode/` are shared by three machines with different user names (`gerasy` on macOS and Arch, `zhora` on the MacBook). Keep paths user-independent: vscode-R takes `${userHome}` in `r.consolePath`; avoid hard-coded home directories.
- On the MacBook `sudo` prompts for a password in Claude sessions. Hand `dnf install` commands to the user and build R packages into the user library instead.

## Editing the Hyprland Config

- The config is Lua: `hypr/.config/hypr/hyprland.lua` plus `conf/keybindings.lua`. Hyprland 0.55+ treats the hyprlang `hyprland.conf` format as legacy and warns about it at every start; if both files exist, the `.lua` wins.
- `~/.config/hypr` is a symlink into this repo and Hyprland auto-reloads on write, so saved edits are live immediately.
- Validate on a copy first: `Hyprland --verify-config -c <copy>.lua`, then check the live result with `hyprctl configerrors`. API reference for the `hl.*` functions: `/usr/share/hypr/stubs/hl.meta.lua`.
- Everything that needs the hy3 plugin (its `plugin.hy3.*` options and `hl.plugin.hy3` dispatchers) is wrapped in `if hy3 then`; hyprpm loads the plugin after the first parse and Hyprland re-runs the config once it is in. Guard any new hy3 usage the same way.
- hy3 option names must match the installed build. List them with `strings /var/cache/hyprpm/$USER/hy3/hy3.so | grep -o 'plugin:hy3:[A-Za-z0-9_.:]*'`; unknown keys are an error in Lua (the old hyprlang block ignored them silently).
- Keybinds carry a `desc`; the Super+K cheat sheet (`scripts/keybindings.sh`) reads them back with `hyprctl binds -j`, so there is no bind syntax to keep in sync.
- `hl.env(...)` values take effect on config reload for apps launched afterwards (rofi-launched apps inherit Hyprland's environment); already running apps need a relaunch, not a logout.
- Window rules match the `class` shown by `hyprctl clients -j`, not the `StartupWMClass` of a desktop file. Electron apps use their desktop-file name as the app id (VS Code is `com.microsoft.VSCode`, Positron `positron` on Wayland but `Positron` under XWayland, WebCatalog apps `webcatalog-<id>`), so check the live class before writing a rule.
- Companion files (`hypridle.conf`, `hyprlock.conf`, `hyprpaper.conf`) are separate programs and stay in hyprlang.
- With the Lua config, `hyprctl dispatch` evaluates its argument as Lua: `hyprctl dispatch 'hl.dsp.exec_cmd("foot")'`, `hyprctl dispatch 'hl.dsp.dpms({ action = "off" })'`, `hyprctl dispatch 'hl.dsp.exit()'`. The old `dispatch exec foot` form fails, and `hyprctl keyword` is gone (use `hyprctl eval`). Any external config that shells out to hyprctl (hypridle, wlogout, waybar on-click) must use the Lua form.
