# Shell completions for tools whose schema isn't captured by man pages.
#
# Baseline coverage comes from `fish_update_completions`, which parses every
# installed man page into ~/.local/share/fish/generated_completions/.
# Re-run it after installing new tools.
#
# This file handles tools that need their native completion script — usually
# because they have rich subcommand structures (pipx install, gh pr view, …).

if not status is-interactive
    exit
end

# --- Python argcomplete tools (pipx, aws-cli, ansible, …) ----------------
# Anything that ships an argcomplete-compatible CLI works the same way.
if type -q register-python-argcomplete
    for cmd in pipx
        if type -q $cmd
            register-python-argcomplete --shell fish $cmd | source
        end
    end
end

# --- Cobra-based Go tools ------------------------------------------------
# Most Cobra CLIs use: `<cmd> completion fish | source`
for cmd in kubectl helm
    if type -q $cmd
        $cmd completion fish 2>/dev/null | source
    end
end

# GitHub CLI uses a different flag syntax.
if type -q gh
    gh completion -s fish 2>/dev/null | source
end

# --- Other patterns to remember ------------------------------------------
# Click-based (pip, black, flask):  _<CMD>_COMPLETE=fish_source <cmd> | source
# rustup / cargo:                   rustup completions fish | source
# deno:                             deno completions fish | source
