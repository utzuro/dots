#!/usr/bin/env bash

exec-once = sh -lc 'eval "$(gnome-keyring-daemon --start --components=secrets,pkcs11 2>/dev/null || true)"; dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL'

# system
#waybar &
dunst &
blueman &
#pypr # enable when I setup any plugins

# apps
GDK_SCALE=1 GDK_DPI_SCALE=1 librewolf &
~/.config/hypr/apps/sig &
~/.config/hypr/apps/discord &
# vesktop &
# ~/.config/hypr/apps/slack &

~/.config/hypr/wall.sh

# ~/.config/hypr/apps/chrome &
# ~/.config/hypr/apps/obsidian &
