#!/usr/bin/env bash

current=$(hyprctl activewindow -j | jq -r ".class")

wlrctl window focus mpv
if ! hyprctl activewindow -j | jq -e '.class' | grep -q "mpv"; then
    exit 0
fi
wlrctl keyboard type 'p'
wlrctl window focus $current
 
