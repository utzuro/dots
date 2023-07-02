#!/usr/bin/env bash
# Install homebrew and use it to install all the tools. If packages are already installed, brew should automatically skip it.

# General: activate in any case.
xcode-select --install > /dev/null

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# shell tools
brew install curl wget zsh git tmux vim docker jq peco ranger zplug node

# pdf
brew tap zegervdv/zathura
brew install zathura zathura-pdf-mupdf

# Extra: can be skipped safely.
brew tap versent/homebrew-taps
brew install tfenv goenv saml2aws jq
brew install ledger
brew install obsidian
brew install scdoc
brew install graphviz
brew install ffmpeg

git clone https://github.com/lucc/nvimpager "${alchemy:?}"/summons
cd "${alchemy:?}"/summons/nvimpager || exit
make install
cd -1 || exit

sh <(curl -L https://nixos.org/nix/install)

# Configure macOS
# Disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Menu bar
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
