#!/bin/bash

current_mode=$(envycontrol --query)

if [ "$current_mode" == "integrated" ]; then
    echo "{\"text\": \"󰿈 integrated\", \"class\": \"integrated\"}"
elif [ "$current_mode" == "hybrid" ]; then
    echo "{\"text\": \" hybrid\", \"class\": \"hybrid\"}"
elif [ "$current_mode" == "nvidia" ]; then
    echo "{\"text\": \" nvidia\", \"class\": \"nvidia\"}"
else
    echo "{\"text\": \"GPU Unknown\", \"class\": \"unknown\"}"
fi