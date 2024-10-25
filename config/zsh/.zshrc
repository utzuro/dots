# Init p10k
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

eval "$(starship init zsh)"

# To customize prompt, run 'p10k configure' or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#----------------------------------------------

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
# zplug romkatv/powerlevel10k, as:theme, depth:1
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
export VISUAL=nvim
export EDITOR=nvim
export fpath=(~/.zsh/completion $fpath)
autoload -U compinit && compinit

# Directories
export alchemy="$HOME/alchemy"
export magic="$HOME/magic"
export manuscripts="$magic/manuscripts"

# Program specific
export GPG_TTY=$(tty)
export npm_config_prefix=~/.node_modules
export LD_LIBRARY_PATH=/usr/local/lib/
export MANGOHUD=0 #1 for fps in steam games
export STARDICT_DATA_DIR=$manuscripts/ingredients/dicts/dic

# PATH
export PATH="$PATH:$(du "$alchemy/scripts" | cut -f2 | sed '/.git/d' | tr '\n' ':' | sed 's/%*$//')"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/bin:/usr/local/sbin"
export PATH="$PATH:/usr/local/opt/python/libexec/bin"
export GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$npm_config_prefix"
export PATH="$PATH:$HOME/.deno/bin"
export PATH="$PATH:$HOME/.emacs/bin"

# Import system specific configurations
source ~/.profile
source ~/.secrets

# Other
if [ -f ~/.awsrc ]; then
  source ~/.awsrc
fi

# Aliases
alias c="clear"
alias upd='git commit -am "update"'
alias amend='git commit --amend'
alias push='git push'
alias force='git push --force'
alias pull='git pull --ff-only'
alias pip='pip3'
alias python='python3'

alias m="myougiden"
alias t="tango"
alias goread="goread -u ~/dots/config/goread/urls.yml"

alias pv="pipe-viewer"

alias ron="redshift -P -O 3200 -b1"
alias roff="redshift -P -O 6200 -b1"

alias ino=arduino-cli

export LEDGER="$manuscripts/ledger/main.ledger"
alias real="ledger -f $LEDGER bal Assets --real"
alias budgets="ledger -f $LEDGER bal Budget Invest"

export PAGER=nvimpager
export MANPAGER="nvimpager"
alias vim="nvim"
alias less="nvimpager"
alias grep="rg"
alias cat="bat"
alias ls="eza"
alias tree="eza --tree"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export ZATHURA_PLUGINS_PATH=/usr/lib/zathura

[ -f "/Users/oleh.skotar/.ghcup/env" ] && . "/Users/oleh.skotar/.ghcup/env" # ghcup-env

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
