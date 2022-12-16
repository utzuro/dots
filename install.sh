#!usr/bin/env bash

# Reliable way to get full path
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# `cd --` in case directory starts with `-`
# `>/dev/null` in case cd has some output

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
echo "configuring xorg..."
ln -sv $DIR/xorg/.Xresources ~/
ln -sv $DIR/xorg/.xinitrc ~/
echo "configuring i3..."
# TODO: check if i3 folder exists
ln -sv $DIR/i3/config ~/.config/i3/
