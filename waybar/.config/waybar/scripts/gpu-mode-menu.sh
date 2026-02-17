#!/bin/bash

modes=("integrated" "hybrid" "nvidia")
icons=("󰿈" "" "")

current_mode=$(envycontrol --query 2>/dev/null)

# Build rofi menu with current mode marked
menu=""
for i in "${!modes[@]}"; do
   if [ "${modes[$i]}" = "$current_mode" ]; then
      menu+="${icons[$i]}  ${modes[$i]} (active)\n"
   else
      menu+="${icons[$i]}  ${modes[$i]}\n"
   fi
done

# Show rofi menu, get selected index
chosen_idx=$(echo -e "$menu" | rofi -dmenu -i -p "GPU" -format i -theme-str 'listview { lines: 3; columns: 1; } window { width: 300px; }')

[ -z "$chosen_idx" ] && exit 0

chosen_mode="${modes[$chosen_idx]}"

# Don't switch if already on this mode
if [ "$chosen_mode" = "$current_mode" ]; then
   notify-send "GPU" "Already in $chosen_mode mode"
   exit 0
fi

pkexec envycontrol --switch "$chosen_mode" && notify-send "GPU" "Switched to $chosen_mode mode. Restart to apply."
