#!/bin/bash

# Get active VPN connections via NetworkManager
active=$(nmcli -t -f NAME,TYPE connection show --active | grep -E ':vpn$|:wireguard$' | cut -d: -f1)

if [ -n "$active" ]; then
   # Join multiple VPN names with comma for tooltip
   names=$(echo "$active" | paste -sd ', ')
   count=$(echo "$active" | wc -l)
   printf '{"text": " 󰌾", "tooltip": "VPN active: %s", "class": "connected", "alt": "connected"}\n' "$names"
else
   printf '{"text": " 󰌿", "tooltip": "VPN disconnected", "class": "disconnected", "alt": "disconnected"}\n'
fi
