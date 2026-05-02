#!/usr/bin/env bash
set -euo pipefail

# --- Homebrew bootstrap and package install ---

echo
echo "⌛... Installing packages for macOS... 🖳"

DIR="$(
	cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit
	pwd -P
)"

# --- Prerequisites ---
xcode-select --install >/dev/null

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

(
	echo
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >>"$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- Shells ---
brew install elvish xonsh zsh zsh-autosuggestions

# --- Shell tools ---
brew install curl wget ack git tig tmux zellij vim neovim nvimpager bat eza jq peco ranger yazi zplug fzf imagemagick ffmpeg tree vhs scdoc sdcv pandoc coreutils fd ripgrep ynqa/tap/jnv starship taskwarrior-tui

# --- Games ---
brew install sl cmatrix

# --- Git ---
brew install gh
gh extension install dlvhdr/gh-dash

# --- Development ---
brew tap tinygo-org/tools
brew install go tinygo python docker node deno yarn postgresql sqlc
deno completions zsh >~/.zsh/_deno

go install golang.org/x/tools/cmd/godoc@latest

# --- System tools ---
brew tap context-labs/mactop https://github.com/context-labs/mactop
brew install mactop

# --- Productivity tools ---
brew install graphviz ledger kitty yt-dlp
brew install --cask obsidian drawio anki visual-studio-code proton-pass figma

# --- Graphical tools ---
brew install --cask libreoffice vlc

brew tap d12frosted/emacs-plus
brew install emacs-plus
osascript -e 'tell application "Finder" to make alias file to posix file "/opt/homebrew/opt/emacs-plus/Emacs.app" at POSIX file "/Applications"'
brew services start d12frosted/emacs-plus/emacs-plus@29

# --- Make macOS feel more like Linux ---
brew install --cask amethyst
brew install --cask clipy
brew install --cask karabiner-elements

# --- Autofocus on hover ---
brew tap dimentium/autoraise
brew install autoraise
brew services start autoraise

brew install yazi ffmpegthumbnailer sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font

# --- Extra tools ---
brew tap versent/homebrew-taps
brew install tfenv saml2aws awscli

# Currently pynvim cannot be installed via brew.
pip3 install 'pynvim @ git+https://github.com/neovim/pynvim' --break-system-packages

# --- Install AWS SSM plugin ---
cd /tmp/
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/sessionmanager-bundle.zip" -o "sessionmanager-bundle.zip"
unzip sessionmanager-bundle.zip
sudo ./sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin
session-manager-plugin --version
cd $DIR

# --- Fonts ---
brew tap homebrew/cask-fonts
brew install font-monaspace
brew install --cask homebrew/cask-fonts/font-0xproto-nerd-font
brew install --cask homebrew/cask-fonts/font-go-mono-nerd-font
brew install --cask homebrew/cask-fonts/font-noto-nerd-font
brew install --cask homebrew/cask-fonts/font-symbols-only-nerd-font

# --- Configure macOS ---
# Disable auto-capitalization.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Finder.
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Menu bar.
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &>/dev/null
done

brew install koekeishiya/formulae/skhd
skhd --start-service

echo "✅ macOS package installation complete!"
