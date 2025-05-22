#!/usr/bin/env bash

if pgrep hyprsunset >/dev/null; then
   if [ "$1" = "toggle" ]; then
      pkill hyprsunset
      notify-send -t 700 "Hyprsunset stopped"
      echo "󰹏"
      pkill -SIGRTMIN+10 waybar
   else
      echo "󱩌"
   fi
else
   if [ "$1" = "toggle" ]; then
      hyprsunset -t 5000 -g 90% &
      notify-send -t 700 "Hyprsunset started"
      echo "󱩌"
      pkill -SIGRTMIN+10 waybar
   else
      echo "󰹏"
   fi
fi
