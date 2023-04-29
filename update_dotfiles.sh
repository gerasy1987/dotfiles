#!/usr/bin/env fish

# Create the dotfiles directory if it doesn't exist
if not test -d ~/dotfiles
    mkdir ~/dotfiles
end

# Declare the config directories
set config_dirs "fish" "kitty" "picom" "xborders" "rofi" "cava" "i3" "neofetch"

# Iterate through the config directories and copy them to ~/dotfiles/
for dir in $config_dirs
    set src_dir ~/.config/$dir
    set dst_dir ~/dotfiles/$dir

    # Check if the source directory exists
    if test -d $src_dir
        # Create the destination directory if it doesn't exist
        if not test -d (dirname $dst_dir)
            mkdir -p (dirname $dst_dir)
        end

        # Copy the config directory
        rsync -av --delete $src_dir/ $dst_dir
        echo "Updated $dst_dir with contents from $src_dir"
    else
        echo "Source directory $src_dir not found. Skipping..."
    end
end

# backup plasma-i3 xsession to dotfiles
cp /usr/share/xsessions/plasma-i3.desktop ~/dotfiles/

# starship settings
cp ~/.config/starship.toml ~/dotfiles/

# shell
cp ~/.bashrc ~/dotfiles/

# vs code
cp ~/.config/Code/User/settings.json ~/dotfiles/Code/User/
cp ~/.config/VSCodium/User/settings.json ~/dotfiles/VSCodium/User/


