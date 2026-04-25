#!/usr/bin/env bash

# Unlock gnome-keyring and export to systemd/dbus environment
eval $(gnome-keyring-daemon --start --components=secrets,pkcs11)
export GNOME_KEYRING_CONTROL
dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL

# system
#waybar &
dunst &
blueman &
#pypr
# wlsunset -l 39.9 -L 116.3 & # replaced with hyprlux

# apps
GDK_SCALE=1 GDK_DPI_SCALE=1 librewolf &
~/.config/hypr/apps/sig &
#########~/.config/hypr/apps/discord &
# ~/.config/hypr/apps/slack &
# vesktop &
~/.config/hypr/wall.sh

# ~/.config/hypr/apps/chrome &
# ~/.config/hypr/apps/obsidian &
