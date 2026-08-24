#!/bin/bash

# Define the config file path
CONFIG_FILE="$HOME/.config/alacritty/alacritty.yml"
NVIM_CONFIG_FILE="$HOME/.config/nvim/after/plugin/colors.lua"

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found at $CONFIG_FILE"
    exit 1
fi
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found at $NVIM_CONFIG_FILE"
    exit 1
fi

# Function to set the theme
set_theme() {
    if [ "$1" == "light" ]; then
        sed -i -e 's/tokyonight-storm.yml/tokyonight-day.yml/g' "$CONFIG_FILE"
        sed -i -e 's/tokyonight-storm/tokyonight-day/g' "$NVIM_CONFIG_FILE"
    elif [ "$1" == "dark" ]; then
        sed -i -e 's/tokyonight-day.yml/tokyonight-storm.yml/g' "$CONFIG_FILE"
        sed -i -e 's/tokyonight-day/tokyonight-storm/g' "$NVIM_CONFIG_FILE"
    else
        echo "Invalid argument. Use 'light' or 'dark'."
        exit 1
    fi

    echo "Theme changed to $1."
}

# Check if an argument is provided
if [ "$#" -eq 1 ]; then
    set_theme "$1"
else
    # Get the current hour
    current_hour=$(date +%H)

    # Set the theme based on the current hour
    if [ "$current_hour" -ge 8 ] && [ "$current_hour" -lt 21 ]; then
        set_theme "light"
    else
        set_theme "dark"
    fi
fi
