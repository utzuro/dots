#!/usr/bin/env bash

if [ -n "$alchemy" ]; then alchemy="$HOME/alchemy"; fi
if [ -n "$manuscripts" ]; then manuscripts="$HOME/magic/manuscripts"; fi

# Reliable way to get full path
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
cd "$DIR" || exit
# `cd --` in case directory starts with `-`
# `>/dev/null` in case cd has some output

# Install packages
printf "⌛... Installing missing packages... 📦☄\n"
#if [[ "$OSTYPE" == "linux-gnu"* ]]; then
#    "$DIR"/packages/archlinux.sh
#elif [[ "$OSTYPE" == "darwin"* ]]; then
#    "$DIR"/packages/mac.sh
#elif [[ "$OSTYPE" == "linux-android"* ]]; then
#    "$DIR"/packages/termux.sh
#elif [[ "$OSTYPE" == "cygwin"* ]]; then
#    "$DIR"/packages/cygwin.sh
#elif [[ "$OSTYPE" == "msys"* ]]; then
#    "$DIR"/packages/ms.sh
#else
#    printf " ¯ \ _ (ツ) _ / ¯  Unknown system, packages won't be installed.\n"
#fi

printf "\n⌛... Creating default folders... 📂\n"
mkdir -p "$alchemy"/ingredients "$HOME"/magic/ingredients
if [ -d "$alchemy"/scripts ]; then
  git clone https://gitlab.com/utzuro/scripts.git "$alchemy"/scripts
  cd "$alchemy"/scripts || exit
  git remote remove origin
  git remote add origin git@gitlab.com:utzuro-utzuro/scripts.git
  cd "$DIR" || exit
fi

# Install all the OS agnostic shell tools
#"$DIR"/packages/shell_install.sh

printf "\n⌛... Linking configuration files to the corresponding places in the system... 🖇\n"
# Vim
ln -sfv "$DIR"/config/vim/.vimrc ~/
ln -sfv "$DIR"/config/vim/.vim/*.vim ~/.vim/
mkdir -p ~/.vim/after/syntax
ln -sfv "$DIR"/config/vim/.vim/after/syntax/asciidoc.vim ~/.vim/after/syntax/
vim +PluginInstall +qall

# Tmux
ln -sfv "$DIR"/config/tmux/.tmux.conf ~/

# Shell
ln -sfv "$DIR"/config/zsh/.zshrc ~/
ln -sfv "$DIR"/config/zsh/.p10k.zsh ~/

# Window manager
if xhost >& /dev/null ; then 
    printf "🧿 Detected Xorg, configuring...\n"
    ln -sfv "$DIR"/config/xorg/.Xresources ~/
    ln -sfv "$DIR"/config/xorg/.xinitrc ~/
fi

if [ -d "$HOME/.config/i3" ]; then
    printf "🧿 Detected i3, configuring...\n"
    ln -sfv "$DIR"/config/i3/config ~/.config/i3/
fi
