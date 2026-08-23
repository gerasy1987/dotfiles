if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Package-manager paths on Apple Silicon macOS and Linuxbrew.
for homebrew_prefix in /opt/homebrew /home/linuxbrew/.linuxbrew
    if test -d $homebrew_prefix/bin
        fish_add_path --global $homebrew_prefix/bin $homebrew_prefix/sbin
        break
    end
end

for user_bin in $HOME/.local/bin $HOME/.cargo/bin
    if test -d $user_bin
        fish_add_path --global $user_bin
    end
end

if status is-interactive; and type -q starship
    starship init fish | source
end

function fish_greeting
   fastfetch --config ~/.config/fastfetch/short
   # sh ~/Downloads/dotfiles/colorscheme.sh
   #  fortune | cowsay | lolcat -g d79921:689d6a
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Load an existing static Conda integration without running Python or
# activating the base environment during every shell startup.
if not functions -q conda
    set -l conda_roots

    if set -q CONDA_EXE; and test -x "$CONDA_EXE"
        set -l conda_exe (path resolve "$CONDA_EXE")
        set -a conda_roots (path dirname (path dirname "$conda_exe"))
    end

    set -l conda_command (command -s conda 2>/dev/null)
    if test -n "$conda_command"; and test -x "$conda_command"
        set conda_command (path resolve "$conda_command")
        set -a conda_roots (path dirname (path dirname "$conda_command"))
    end

    set -a conda_roots \
        /opt/homebrew/Caskroom/miniconda/base \
        $HOME/miniconda3 \
        $HOME/anaconda3 \
        $HOME/miniforge3 \
        $HOME/mambaforge \
        /opt/miniconda3 \
        /opt/miniforge3 \
        /opt/conda

    for conda_root in $conda_roots
        set -l conda_fish $conda_root/etc/fish/conf.d/conda.fish
        if test -r $conda_fish
            source $conda_fish
            break
        end
    end
end
