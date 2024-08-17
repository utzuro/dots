#!/usr/bin/env bash

# system
# swww init &
# swww img /mnt/seance/mysticism/i/wallpapers/109480.jpg &
waybar &
dunst &
blueman &
wlsunset -l 39.9 -L 116.3 &

# apps
GDK_SCALE=1 GDK_DPI_SCALE=1 librewolf &
GDK_SCALE=2 GDK_DPI_SCALE=2 steam &
~/.config/hypr/apps/chrome &
~/.config/hypr/apps/obsidian &
~/.config/hypr/apps/sig &
~/.config/hypr/apps/discord


