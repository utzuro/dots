#!/usr/bin/env bash

# Use wget or curl to install OS agnostic tools.

# General: activate in any case.
# Requires curl, git, zsh

printf "\n⌛... Installing shell tools... 🛠\n"
if ! [ -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else printf "📝 Oh My Zsh seems to be already installed! Remove ~/.oh-my-zsh to reinstall. 🚀\n"
fi

if ! [ -d "$HOME/.zplug/" ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  printf "📝 Install zsh plugins with zplug install! 🚀\n"
else printf "📝 Zplug seems to be already installed! Remove ~/.zplug to reinstall. 🚀\n"
fi

if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else printf "📝 Vundle seems to be already installed! Remove ~/.vim/bundle/Vundle.vim to reinstall. 🚀\n"
fi

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  printf "📝 Install tmux plugins with ctrl+B + I 🚀\n"
else printf "📝 TPM seems to be already installed! Remove ~/.tmux/plugins/tpm to reinstall. 🚀\n"
fi

if ! [ -d "$HOME/.goenv" ]; then
  git clone https://github.com/syndbg/goenv.git "$HOME/.goenv"
else printf "📝 GoENV seems to be already installed! Remove ~/.goenv to reinstall. 🚀\n"
fi

printf "\n🔥 Shell tools installation complete! 🔥\n"
