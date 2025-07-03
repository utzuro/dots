# Shell options
set -o vi

# Editors
export VISUAL="nvim"
export EDITOR="nvim"

# Directories
export alchemy="$HOME/alchemy"
export a="$HOME/alchemy"
export magic="$HOME/magic"
export m="$HOME/magic"
export manuscripts="$alchemy/manuscripts"
export manu="$alchemy/manuscripts"

# Data paths
export STARDICT_DATA_DIR="$manuscripts/ingredients/dicts/dic"
export LEDGER="$alchemy/manuscripts/ledger/main.ledger"
export ZATHURA_PLUGINS_PATH="/usr/lib/zathura"
export CHROME_EXECUTABLE="chrome"

# Dev
export GOPATH="$HOME/go"
export GOPRIVATE="github.com/*"
export PATH="$PATH:$GOPATH/bin"

# Fonts and Nix options
export QT_FONT_DPI="204"
export NIXPKGS_ALLOW_INSECURE="1"
export NIXPKGS_ALLOW_UNFREE="1"

# XDG base dirs
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOWNLOAD_DIR="$HOME/channeling"
export XDG_TEMPLATES_DIR="$magic"
export XDG_PUBLICSHARE_DIR="$magic"
export XDG_DOCUMENTS_DIR="$magic"
export XDG_MUSIC_DIR="$magic"
export XDG_PICTURES_DIR="$magic"
export XDG_VIDEOS_DIR="$magic"

# Aliases
alias c="clear"
alias vim="nvim"
alias v="nvim"
alias ls="eza"
alias tree="eza --tree"
alias cat="bat"
alias todo="vim ~/todo"
alias mpv="mpv --alang=jpn"
alias yt="yt-dlp --no-playlist"

# Git
alias upd='git commit -am "update" && git push'
alias push='git push'
alias pull='git pull --ff-only'
alias pul='git pull --ff-only'
alias rebase='git pull --rebase'
alias force='git push --force'
alias forc='git push --force'
alias amend='git commit --amend'

# Apps
alias m="myougiden"
alias t="tango"
alias pv="pipe-viewer"
alias ron="redshift -P -O 3200 -b1"
alias roff="redshift -P -O 6200 -b1"
alias ino="arduino-cli"
alias real="ledger -f $LEDGER bal Assets --real"
alias budgets="ledger -f $LEDGER bal Budget"

# Pagers
export PAGER="nvimpager"
export MANPAGER="nvimpager"

# Load Nix if present
if [ -e /home/ssm-user/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/ssm-user/.nix-profile/etc/profile.d/nix.sh
fi

# Load custom secrets if present
[ -f ~/.secrets ] && source ~/.secrets

# Load AWS creds if present
[ -f ~/.awsrc ] && source ~/.awsrc

