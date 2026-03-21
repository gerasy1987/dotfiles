#! /bin/bash

# Check if playerctl is available
if ! command -v playerctl >/dev/null 2>&1; then
   exit 0
fi

playerctl metadata --follow --format '{{markup_escape(title)}} - {{markup_escape(artist)}}|{{ duration(position) }}/{{ duration(mpris:length) }}' 2>/dev/null | while IFS='|' read -r text timer; do
   maxlength=35
   # if the text is longer than the max length, truncate it and add "..."
   if [ ${#text} -gt $maxlength ]; then
      text=${text:0:$maxlength-3}"..."
   fi

   playerctl metadata -f '{"text": "'"$text $timer"'", "tooltip": "{{playerName}} : {{markup_escape(title)}} - {{markup_escape(artist)}}  {{ duration(position) }}/{{ duration(mpris:length) }}", "alt": "{{status}}", "class": "{{status}}"}'
done