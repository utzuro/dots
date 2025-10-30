# Configs
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/.zprofile
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug load

plugins=(git gitignore colored-man-pages command-not-found history zsh-interactive-cd web-search z)
source $ZSH/oh-my-zsh.sh

# Plugin configs
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '[A' history-substring-search-up
bindkey '[B' history-substring-search-down

# Shell options
set -o vi

# Env
export EDITOR="nvim"
export VISUAL="nvim"

export alchemy="$HOME/alchemy"
export a="$HOME/alchemy"
export magic="$HOME/magic"
export m="$HOME/magic"
export manuscripts="$alchemy/manuscripts"
export manu="$alchemy/manuscripts"

export XDG_CONFIG_HOME="$HOME/.config"

export STARDICT_DATA_DIR="$manuscripts/ingredients/dicts/dic"
export LEDGER="$HOME/alchemy/manuscripts/ledger/main.ledger"

export ZATHURA_PLUGINS_PATH="/usr/lib/zathura"
export CHROME_EXECUTABLE="chrome"

export GOPATH="$HOME/go"
export GOPRIVATE="github.com/*"
export PATH="$PATH:$GOPATH/bin"

export NIXPKGS_ALLOW_INSECURE="1"
export NIXPKGS_ALLOW_UNFREE="1"

export QT_FONT_DPI="204"

# Import system specific configurations
source ~/.profile
source ~/.secrets

# Other
if [ -f ~/.awsrc ]; then
  source ~/.awsrc
fi

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

# git
alias upd="git commit -am 'update' && git push"
alias push="git push"
alias pull="git pull --ff-only"
alias pul="git pull --ff-only"
alias rebase="git pull --rebase"
alias force="git push --force"
alias forc="git push --force"
alias amend="git commit --amend"

# run apps from terminal
alias pv="pipe-viewer"
alias m="myougiden"
alias t="tango"
alias ron="redshift -P -O 3200 -b1"
alias roff="redshift -P -O 6200 -b1"
alias ino="arduino-cli"
alias real="ledger -f $LEDGER bal Assets --real"
alias budgets="ledger -f $LEDGER bal Budget"

# dev tools
alias k8s="kubectl"
alias clion="nohup clion >/dev/null 2>&1 &"
alias goland="nohup goland >/dev/null 2>&1 &"
alias pycharm="nohup pycharm-community >/dev/null 2>&1 &"

# browsers
alias chrome="nohup chromium >/dev/null 2>&1 &"
alias libre="nohup librewolf >/dev/null 2>&1 &"
alias firefox="nohup firefox >/dev/null 2>&1 &"

# AI
alias expl="gh copilot explain"
alias sugg="gh copilot suggest"

# system
alias build-my-home="./ingr/cleanup && home-manager switch --flake .#void --impure"
alias open-port="while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || { echo -e 'ERROR' ; break ; } ; sleep 45 ; done"
export MY_HOMEMANAGER="~/alchemy/summons/nixos/home-manager"

#XDG DIRS
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOWNLOAD_DIR="$HOME/channeling"
export XDG_TEMPLATES_DIR="$magic"
export XDG_PUBLICSHARE_DIR="$magic"
export XDG_DOCUMENTS_DIR="$magic"
export XDG_MUSIC_DIR="$magic"
export XDG_PICTURES_DIR="$magic"
export XDG_VIDEOS_DIR="$magic"

export XDG_RUNTIME_DIR DEFAULT=/var/tmp/xdg
export XDG_DATA_DIRS DEFAULT=/usr/local/share:/usr/share
export XDG_CACHE_HOME  DEFAULT=@{HOME}/.cache
export XDG_CONFIG_HOME DEFAULT=@{HOME}/.config
export XDG_DATA_HOME   DEFAULT=@{HOME}/.local/share
export XDG_STATE_HOME  DEFAULT=@{HOME}/.local/state

[ -f "/Users/oleh.skotar/.ghcup/env" ] && . "/Users/oleh.skotar/.ghcup/env" # ghcup-env

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
