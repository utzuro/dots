#!usr/bin/env bash

# Reliable way to get full path
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# `cd --` in case directory starts with `-`
# `>/dev/null` in case cd has some output

# install packages
echo "Installing missing packages..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $DIR/packages/archlinux.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    $DIR/packages/mac.sh
elif [[ "$OSTYPE" == "cygwin"* ]]; then
    $DIR/packages/cygwin.sh
elif [[ "$OSTYPE" == "msys"* ]]; then
    $DIR/packages/ms.sh
else
    echo "Unkown system, packages won't be installed."
fi

echo "Linking configuration files to the correspoding places in the system..."
echo "For safety, link won't be created if file already exists."

# vim
echo "configuring vim..."
ln -sv $DIR/vim/.vimrc ~/
ln -sv $DIR/vim/.vim/* ~/.vim/
echo "Creating folder ~/.vim/after/syntax..."
mkdir -p ~/.vim/after/syntax
ln -sv $DIR/vim/.vim/after/syntax/asciidoc.vim ~/.vim/after/syntax/

# tmux
echo "configuring tmux..."
ln -sv $DIR/vim/.tmux ~/

# shell
echo "configuring zsh..."
ln -sv $DIR/vim/.zshrc ~/

# window manager
# TODO: check if xorg
echo "configuring xorg..."
ln -sv $DIR/xorg/.Xresources ~/
ln -sv $DIR/xorg/.xinitrc ~/
echo "configuring i3..."
# TODO: check if i3 folder exists
ln -sv $DIR/i3/config ~/.config/i3/
