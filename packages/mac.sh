#!/usr/bin/env bash
# Install homebrew and use it to install all the tools. If packages are already installed, brew should automatically skip it.

# General: activate in any case.
xcode-select --install 

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# shell tools
brew install curl wget zsh git tmux vim docker jq peco ranger zplug

# pdf
brew tap zegervdv/zathura
brew install zathura zathura-pdf-mupdf

# Extra: can be skipped safely.
brew tap versent/homebrew-taps
brew install tfenv goenv saml2aws jq
brew install ledger
brew install obsidian
