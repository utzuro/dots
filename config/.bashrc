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
alias wget="wget2"
alias todo="vim ~/todo"
alias mpv="mpv --alang=jpn"
alias yt="yt-dlp --no-playlist"
alias ytp='yt-dlp -f "bv*[height<=2160]+ba/b" --cookies-from-browser firefox'
alias k="ps aux | fzf | awk '{print }' | xargs -r kill -9"

# Git
alias upd="git commit -am 'minor update' && git push"
alias bump="git commit -am 'version bump' && git push"
alias refactor="git commit -am 'refactor' && git push"
alias hotfix="git commit -am 'hotfix' && git push"
alias addtests="git commit -am 'add tests' && git push"
alias com='git commit'
alias push='git push'
alias pull='git pull --ff-only'
alias pul='git pull --ff-only'
alias pl='git pull --ff-only'
alias rebase='git pull --rebase'
alias force='git push --force-with-lease'
alias forc='git push --force-with-lease'
alias amend='git commit --amend'
alias diff='git diff --color-words'
alias cached='git diff --cached --color-words'
alias changes='git diff main --color-words'
alias chmain='git diff main --name-only'
alias chmaster='git diff main --name-only'
alias chdev='git diff main --name-only'

# Apps
alias m="myougiden"
alias t="tango"
alias pv="pipe-viewer"
alias ron="redshift -P -O 3200 -b1"
alias roff="redshift -P -O 6200 -b1"
alias ino="arduino-cli"
alias real="ledger -f $LEDGER bal Assets --real"
alias budgets="ledger -f $LEDGER bal Budget"
alias k8s='kubectl'
alias idea='nohup idea-ultimate >/dev/null 2>&1 &'
alias goland='nohup goland >/dev/null 2>&1 &'
alias pycharm='nohup pycharm-professional >/dev/null 2>&1 &'
alias clion='nohup clion >/dev/null 2>&1 &'
alias rustrover='nohup rust-rover >/dev/null 2>&1 &'
alias rubymine='nohup ruby-mine >/dev/null 2>&1 &'
alias rider='nohup rider >/dev/null 2>&1 &'
alias webstorm='nohup webstorm >/dev/null 2>&1 &'
alias datagrip='nohup datagrip >/dev/null 2>&1 &'
alias studio='nohup android-studio >/dev/null 2>&1 &'
alias code='nohup code >/dev/null 2>&1 &'
alias dbeaver='nohup dbeaver >/dev/null 2>&1 &'
alias postman='nohup postman >/dev/null 2>&1 &'
alias notion='nohup notion-app >/dev/null 2>&1 &'
alias chrome='nohup chromium >/dev/null 2>&1 &'
alias libre='nohup librewolf >/dev/null 2>&1 &'
alias firefox='nohup firefox >/dev/null 2>&1 &'

# AI
alias expl='gh copilot explain '
alias sugg='gh copilot suggest'

# System
alias MY_HOMEMANAGER='~/alchemy/summons/nixos/home-manager'
alias build-my-home='./ingr/cleanup && home-manager switch --flake .#$USER --impure'
alias open-port="while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || { echo -e 'ERROR' ; break ; } ; sleep 45 ; done"
alias XDG_DESKTOP_DIR='$HOME/'
alias XDG_DOWNLOAD_DIR='$HOME/channeling'
alias XDG_TEMPLATES_DIR='$HOME/magic'
alias XDG_PUBLICSHARE_DIR='$HOME/magic'
alias XDG_DOCUMENTS_DIR='$HOME/magic'
alias XDG_MUSIC_DIR='$HOME/magic'
alias XDG_PICTURES_DIR='$HOME/magic'
alias XDG_VIDEOS_DIR='$HOME/magic'

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
