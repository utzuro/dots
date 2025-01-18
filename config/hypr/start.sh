#!/usr/bin/env bash

# system
swww init &
swww img ~/wallpaper.png
waybar &
dunst &
blueman &
# wlsunset -l 39.9 -L 116.3 & # replaced with hyprlux

# apps
GDK_SCALE=1 GDK_DPI_SCALE=1 librewolf &
~/.config/hypr/apps/sig &
~/.config/hypr/apps/discord

# ~/.config/hypr/apps/chrome &
# ~/.config/hypr/apps/obsidian &


