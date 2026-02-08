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
