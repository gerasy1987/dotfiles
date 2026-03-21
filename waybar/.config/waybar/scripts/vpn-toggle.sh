#!/bin/bash

# Get all VPN connections as an array
mapfile -t all_vpns < <(nmcli -t -f NAME,TYPE connection show | grep -E ':vpn$|:wireguard$' | cut -d: -f1)

if [ ${#all_vpns[@]} -eq 0 ]; then
   notify-send "VPN" "No VPN connections configured"
   exit 0
fi

# Get active VPN connections
active_vpns=$(nmcli -t -f NAME,TYPE connection show --active | grep -E ':vpn$|:wireguard$' | cut -d: -f1)

# Build rofi menu with status icons
menu=""
for vpn in "${all_vpns[@]}"; do
   if echo "$active_vpns" | grep -qxF "$vpn"; then
      menu+="󰌾 $vpn\n"
   else
      menu+="󰌿 $vpn\n"
   fi
done

# Show rofi menu, get selected index
chosen_idx=$(echo -e "$menu" | rofi -dmenu -i -p "VPN" -format i -theme-str 'listview { lines: 5; columns: 1; } window { width: 350px; }')

[ -z "$chosen_idx" ] && exit 0

# Look up the VPN name by index
vpn_name="${all_vpns[$chosen_idx]}"

# Toggle: if active, disconnect; if inactive, connect
if echo "$active_vpns" | grep -qxF "$vpn_name"; then
   nmcli connection down "$vpn_name" && notify-send "VPN" "Disconnected: $vpn_name"
else
   nmcli connection up "$vpn_name" && notify-send "VPN" "Connected: $vpn_name"
fi
