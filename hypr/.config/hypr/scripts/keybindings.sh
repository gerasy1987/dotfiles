#!/bin/bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#
# -----------------------------------------------------
# Get keybindings location based on variation
# -----------------------------------------------------
config_file="$HOME/.config/hypr/conf/keybindings.conf"

# -----------------------------------------------------
# Path to keybindings config file
# -----------------------------------------------------
echo "Reading from: $config_file"

keybinds=$(awk '
   $1 ~ /^bind(m|el)?/ {
      line = $0
      gsub(/\$mainMod/, "SUPER", line)
      sub(/^bind(m|el)?[[:space:]]*=[[:space:]]*/, "", line)
      split(line, arr, /,[[:space:]]*/)
      key1 = arr[1]
      key2 = arr[2]
      # Extract comment after #
      comment = ""
      if (match(line, /#[[:space:]]*(.*)$/, arr)) {
         comment = arr[1]
         gsub(/^[[:space:]]+|[[:space:]]+$/, "", comment)
      }
      print key1 " " key2 ": " comment
   }
' "$config_file")

sleep 0.2
rofi -dmenu -i -replace -p "keybinds" -config $HOME/.config/rofi/config_wide.rasi <<<"$keybinds"
