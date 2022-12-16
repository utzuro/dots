#!usr/bin/env bash

# Use wget or curl to install OS agnostic tools.

# General: activate in any case.
# Requires curl, git, zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Extra: can be skipped safely.
