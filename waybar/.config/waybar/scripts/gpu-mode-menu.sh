#!/bin/bash

choice=$(yad --list --title="Switch GPU Mode" --column="Select GPU Mode" integrated hybrid nvidia)

if [ -z "$choice" ]; then
    exit 0
else
    pkexec envycontrol --switch $choice && notify-send "Switched to $choice mode.
Restart to apply changes."
fi