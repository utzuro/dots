#!/usr/bin/env bash

alchemy="$HOME/alchemy"
magic="$HOME/magic"

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

printf "\n⌛... Creating default folders... 📂\n"
touch "${HOME:?}"/.profile
touch "${HOME:?}"/.zprofile
touch "${HOME:?}"/.secrets
touch "${HOME:?}"/.awsrc
mkdir -p "${alchemy:?}"/{ingredients,summons} ${magic:?}/ingredients "$HOME"/aws
if ! [ -d "$alchemy"/scripts ]; then
  git clone https://gitlab.com/utzuro/scripts.git "$alchemy"/scripts
  cd "$alchemy"/scripts || exit
  git remote remove origin
  git remote add origin git@gitlab.com:utzuro/scripts.git
  cd "$DIR" || exit
fi

printf "\n⌛... Linking files... 🖇\n"
ln -sfv "$DIR"/ing/i/.face "$HOME"/
ln -sfv "$DIR"/ing/i/background.png "$HOME"/

printf "\n⌛... Coping system depended files to be edited by user... 🖇\n"
cp -n "$DIR"/system-depended/.profile "$HOME"/
source "$HOME"/.profile

# Install all the OS agnostic shell tools
# "$DIR"/packages/shell_install.sh

printf "\n⌛... Linking configuration files to the corresponding places in the system... 🖇\n"
# Vim
ln -sfv "$DIR"/config/vim/.vimrc "$HOME"/
mkdir "$HOME"/.config/nvim
ln -sfv "$DIR"/config/vim/nvim/init.vim "$HOME"/.config/nvim/init.vim
ln -sfv "$DIR"/config/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
# TODO: Move configs to lua
# mkdir -p "$HOME"/.config/nvim/lua/utils
# ln -sfv "$DIR"/config/vim/nvim/init.lua "$HOME"/.config/nvim/
# ln -sfv "$DIR"/config/vim/nvim/lua/*.lua "$HOME"/.config/nvim/lua/
# ln -sfv "$DIR"/config/vim/nvim/lua/utils/*.lua "$HOME"/.config/nvim/lua/utils/
ln -sfv "$DIR"/config/vim/.ideavimrc "$HOME"/
ln -sfv "$DIR"/config/vim/.vim/*.vim "$HOME"/.vim/
mkdir -p "$HOME"/.vim/after/syntax
ln -sfv "$DIR"/config/vim/.vim/after/syntax/asciidoc.vim "$HOME"/.vim/after/syntax/
vim +PluginInstall +qall

# Shell
# ignore dots that are already defined with HomeManager on nix
if [ ! -d "$HOME"/.nix-profile ]; then
    ln -sfv "$DIR"/config/zsh/.zshrc "$HOME"/
    ln -sfv "$DIR"/config/.bashrc "$HOME"/
fi

ln -sfv "$DIR"/config/tmux/.tmux.conf "$HOME"/
ln -sfv "$DIR"/config/zsh/.p10k.zsh "$HOME"/

# Tools
mkdir -p "$HOME"/.config/ranger
ln -sfv "$DIR"/config/ranger/rc.conf "$HOME"/.config/ranger/rc.conf

# SSH
mkdir -p "$HOME"/.ssh
cp -n "$DIR"/config/ssh/config "$HOME"/.ssh/

# Window manager
# TODO: Add support for wayland
# TODO: Define all of this with home-manager on nix
if xhost >& /dev/null ; then 
    printf "🧿 Detected Xorg, configuring...\n"
    ln -sfv "$DIR"/config/xorg/.xinitrc "$HOME"/
    mkdir -p "$HOME"/.config/{dunst,rofi,mpd,ncmpcpp,waybar,goread}
    ln -sfv "$DIR"/config/dunst/* "$HOME"/.config/dunst/
    ln -sfv "$DIR"/config/goread/* "$HOME"/.config/goread/
    # ln -sfv "$DIR"/config/rofi/* "$HOME"/.config/rofi/
    ln -sfv "$DIR"/config/ranger/* "$HOME"/.config/ranger/
    ln -sfv "$DIR"/config/mpd/* "$HOME"/.config/mpd/
    ln -sfv "$DIR"/config/ncmpcpp/* "$HOME"/.config/ncmpcpp/
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

