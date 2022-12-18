#!/usr/bin/env bash

# Reliable way to get full path
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
# `cd --` in case directory starts with `-`
# `>/dev/null` in case cd has some output

# Install packages
echo "⌛... Installing missing packages... 📦☄"
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
#    echo " ¯ \ _ (ツ) _ / ¯  Unknown system, packages won't be installed."
#fi

echo "⌛... Creating default folders... 📂"
mkdir -p ~/alchemy/{scripts,ingredients} ~/magic/{manuscripts,ingredients}

# Install all the OS agnostic shell tools
"$DIR"/packages/shell_install.sh

echo "⌛... Linking configuration files to the corresponding places in the system... 🖇"
# Vim
ln -sfv "$DIR"/config/vim/.vimrc ~/
ln -sfv "$DIR"/config/vim/.vim/* ~/.vim/
mkdir -p ~/.vim/after/syntax
ln -sfv "$DIR"/config/vim/.vim/after/syntax/asciidoc.vim ~/.vim/after/syntax/
vim +PluginInstall +qall

# Tmux
ln -sfv "$DIR"/config/vim/.tmux ~/

# Shell
ln -sfv "$DIR"/config/zsh/.zshrc ~/
zplug install

# Window manager
if xhost >& /dev/null ; then 
    echo "🧿 Detected Xorg, configuring..."
    ln -sfv "$DIR"/config/xorg/.Xresources ~/
    ln -sfv "$DIR"/config/xorg/.xinitrc ~/
fi

if [ -f "$HOME/.config/i3/config" ]; then 
    echo "🧿 Detected i3, configuring..."
    ln -sfv "$DIR"/config/i3/config ~/.config/i3/
fi
