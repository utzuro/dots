#!/usr/bin/env bash
# Install homebrew and use it to install all the tools. If packages are already installed, brew should automatically skip it.

# General: activate in any case.
xcode-select --install > /dev/null

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# shell tools
brew install curl wget zsh zsh-autosuggestions ack git tig tmux vim neovim nvimpager bat jq peco ranger zplug fzf imagemagick ffmpeg tree vhs neofetch scdoc sdcv pandoc coreutils fd ripgrep 

# dev
brew install go goenv tinygo python docker node deno yarn postgresql sqlc
deno completions zsh > ~/.zsh/_deno

# install go versions but don't activate them
goenv install 1.19.0
goenv install 1.19.4
goenv install 1.20.0

# tools
brew install graphviz ledger obsidian kitty 

brew install emacs-plus
osascript -e 'tell application "Finder" to make alias file to posix file "/opt/homebrew/opt/emacs-plus@29/Emacs.app" at POSIX file "/Applications"'
brew services start d12frosted/emacs-plus/emacs-plus@29

# extra tools
brew tap versent/homebrew-taps
brew install tfenv saml2aws

# fonts
brew tap homebrew/cask-fonts
brew install font-monaspace
brew install --cask homebrew/cask-fonts/font-0xproto-nerd-font
brew install --cask homebrew/cask-fonts/font-go-mono-nerd-font
brew install --cask homebrew/cask-fonts/font-noto-nerd-font
brew install --cask homebrew/cask-fonts/font-symbols-only-nerd-font

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

brew install koekeishiya/formulae/skhd
skhd --start-service
