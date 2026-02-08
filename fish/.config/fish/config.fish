if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
fish_add_path /home/zhora/.local/bin
fish_add_path /home/zhora/.cargo/bin/

function fish_greeting
   fastfetch --config ~/.config/fastfetch/short
   # sh ~/Downloads/dotfiles/colorscheme.sh
   #  fortune | cowsay | lolcat -g d79921:689d6a
end
