#!usr/bin/env bash

echo "Linking configuration files to the correspoding places in the system..."
echo "Link won't be created if file already exists."

echo "configuring vim..."
ln -sv $(pwd)/vim/.vimrc ~/
ln -sv $(pwd)/vim/.vim/* ~/.vim/

echo "Creating folder ~/.vim/after/syntax..."
mkdir -p ~/.vim/after/syntax
ln -sv $(pwd)/vim/.vim/after/syntax/asciidoc.vim ~/.vim/after/syntax/

echo "configuring tmux..."
ln -sv $(pwd)/vim/.tmux ~/

echo "configuring zsh..."
ln -sv $(pwd)/vim/.zshrc ~/

