#!/usr/bin/env bash

# Use wget or curl to install OS agnostic tools.

# General: activate in any case.
# Requires curl, git, zsh

echo "⌛... Installing shell tools... 🛠"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "📝 Install tmux plugins with ctrl+B + I"

echo "🔥 Shell tools installation complete! 🔥"
