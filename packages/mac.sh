#!/usr/bin/env bash
# Install homebrew and use it to install all the tools. If packages are already installed, brew should automatically skip it.

DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# General: activate in any case.
xcode-select --install > /dev/null

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/oleh.skotar/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

# shells
brew install elvish xonsh zsh zsh-autosuggestions

# shell tools
brew install curl wget  ack git tig tmux zellij vim neovim nvimpager bat eza jq peco ranger yazi zplug fzf imagemagick ffmpeg tree vhs scdoc sdcv pandoc coreutils fd ripgrep ynqa/tap/jnv starship taskwarrior-tui

# games
brew install sl cmatrix

# git
brew install gh
gh extension install dlvhdr/gh-dash

# dev
brew tap tinygo-org/tools
brew install go tinygo python docker node deno yarn postgresql sqlc
deno completions zsh > ~/.zsh/_deno 

go install golang.org/x/tools/cmd/godoc@latest

# sys
brew tap context-labs/mactop https://github.com/context-labs/mactop
brew install mactop

# tools
brew install graphviz ledger kitty yt-dlp 
brew install --cask obsidian drawio anki visual-studio-code

# graphical tools
brew install --cask libreoffice vlc

brew tap d12frosted/emacs-plus
brew install emacs-plus
osascript -e 'tell application "Finder" to make alias file to posix file "/opt/homebrew/opt/emacs-plus/Emacs.app" at POSIX file "/Applications"'
brew services start d12frosted/emacs-plus/emacs-plus@29

brew install --cask amethyst
brew install --cask clipy
brew install --cask karabiner-elements

brew install yazi ffmpegthumbnailer sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font

# extra tools
brew tap versent/homebrew-taps
brew install tfenv saml2aws awscli

# currently pynvim cant be installed via brew
pip3 install 'pynvim @ git+https://github.com/neovim/pynvim' --break-system-packages

# install aws ssm-plugin
cd /tmp/
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/sessionmanager-bundle.zip" -o "sessionmanager-bundle.zip"
unzip sessionmanager-bundle.zip
sudo ./sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin
session-manager-plugin --version
cd $DIR

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
