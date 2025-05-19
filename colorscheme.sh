#!/bin/bash

# Print a new line before all tiles
echo

# Function to generate a taller tile with a specified color
generate_tile() {
  local color_code=$1
  echo -ne "$(tput setaf $color_code)\u2588\u2588$(tput sgr0) "  # Create a taller tile and add spaces for gaps
}

# Main colors of the terminal color scheme
colors=(
  0  # Black
  1  # Red
  2  # Green
  3  # Yellow
  4  # Blue
  5  # Magenta
  6  # Cyan
  7  # White
)

# Generate tiles for each color and position them horizontally
for color in "${colors[@]}"; do
  generate_tile "$color"
done

# Print a new line after all tiles
echo
