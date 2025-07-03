#!/usr/bin/env bash

# Reliable way to get full path
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
cd "$DIR" || exit
# `cd --` in case directory starts with `-`
# `>/dev/null` in case cd has some output

# Install packages
printf "⌛... Installing missing packages... 📦☄\n"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    read -rp "👾 Install archlinux packages? (y/N) 👀  " yn
    if [ "$yn" == "y" ]; then
        "$DIR"/packages/archinstall.sh
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    read -rp "Install homebrew packages? (y/N) 👀  " yn
    if [ "$yn" == "y" ]; then
        "$DIR"/packages/mac.sh
    fi
elif [[ "$OSTYPE" == "linux-android"* ]]; then
    "$DIR"/packages/termux.sh
elif [[ "$OSTYPE" == "cygwin"* ]]; then
    "$DIR"/packages/cygwin.sh
elif [[ "$OSTYPE" == "msys"* ]]; then
    "$DIR"/packages/win.sh
else
    printf " ¯ \ _ (ツ) _ / ¯  Unknown system, packages won't be installed.\n"
fi

# Window manager related
if xhost >& /dev/null ; then 
    printf "🧿 Detected Xorg, configuring...\n"
    ln -sfv "$DIR"/config/xorg/.xinitrc "$HOME"/
    mkdir -p "$HOME"/.config/{dunst,rofi,mpd,ncmpcpp,waybar,goread}
    ln -sfv "$DIR"/config/dunst/* "$HOME"/.config/dunst/
    ln -sfv "$DIR"/config/goread/* "$HOME"/.config/goread/
    # ln -sfv "$DIR"/config/rofi/* "$HOME"/.config/rofi/
    ln -sfv "$DIR"/config/ranger/* "$HOME"/.config/ranger/
    ln -sfv "$DIR"/config/mpd/* "$HOME"/.config/mpd/
    ln -sfv "$DIR"/config/waybar/* "$HOME"/.config/waybar/
    cp -n "$DIR"/config/xorg/.Xresources "$HOME"/
    # Remove 4K configs if no 4K monitor is found
    UHD="$(xrandr | awk '/3840x/ {print $1}')"
    if [ ! "$UHD" ]; then
        sed -i -e 's/^Xft.dpi: 192/!Xft.dpi: 192/' ~/.Xresources --follow-symlinks
    fi
fi

if [ -d "$HOME/.config/i3" ]; then
    printf "🧿 Detected i3, configuring...\n"
    ln -sfv "$DIR"/config/i3/config "$HOME"/.config/i3/
fi

if [ -d "$HOME/.config/hypr" ]; then
    rm -rf "$HOME"/.config/hypr
    printf "🧿 Detected hyprland, configuring...\n"
    ln -sfv "$DIR"/config/hypr "$HOME"/.config/
fi

printf "\n⌛... Installing and configuring OS agnostic pkgs... 📂\n"
"$DIR"/packages/shell_install.sh
