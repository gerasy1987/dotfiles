#!/bin/bash

current_mode=$(envycontrol --query)

if [ "$current_mode" == "integrated" ]; then
    echo "{\"text\": \"󰿈\", \"tooltip\": \"integrated\"}"
elif [ "$current_mode" == "hybrid" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"hybrid\"}"
elif [ "$current_mode" == "nvidia" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"nvidia\"}"
else
    echo "{\"text\": \"GPU Unknown\", \"tooltip\": \"unknown\"}"
fi