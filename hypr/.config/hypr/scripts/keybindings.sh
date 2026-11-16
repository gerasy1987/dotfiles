#!/bin/bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#
# Keybinding cheat sheet. Reads the live binds from Hyprland; the text comes from the
# desc field of each hl.bind() in conf/keybindings.lua, so no config parsing is needed.

keybinds=$(hyprctl binds -j | jq -r '
  def mods:
    [ (if ((.modmask / 64) | floor) % 2 == 1 then "SUPER" else empty end),
      (if ((.modmask / 4)  | floor) % 2 == 1 then "CTRL"  else empty end),
      (if ((.modmask / 8)  | floor) % 2 == 1 then "ALT"   else empty end),
      (if  .modmask % 2 == 1                  then "SHIFT" else empty end) ];
  .[] | select(.has_description)
      | ((mods + [.key]) | join(" + ")) + ": " + .description')

rofi -dmenu -i -replace -p "keybinds" -config "$HOME/.config/rofi/config_wide.rasi" <<<"$keybinds"
