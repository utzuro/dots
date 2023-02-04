# Init p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#----------------------------------------------

# Configs
source ~/.oh-my-zsh/oh-my-zsh.sh
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug load

plugins=(git gitignore colored-man-pages command-not-found history zsh-interactive-cd tmux web-search z)
source $ZSH/oh-my-zsh.sh

# Plugin configs
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '[A' history-substring-search-up
bindkey '[B' history-substring-search-down

# Shell options
set -o vi
export VISUAL=vim
export EDITOR=vim
export fpath=(~/.zsh/completion $fpath)

# Directories
export alchemy="$HOME/alchemy"
export manuscripts="$HOME/magic/manuscripts"

# PATH
export PATH="$PATH:$(du "$alchemy/scripts" | cut -f2 | sed '/.git/d' | tr '\n' ':' | sed 's/%*$//')"
export PATH=$PATH:$HOME/bin
export GOPATH=$HOME/go
export GOENV_DISABLE_GOPATH=1
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# Import system specific configurations
source ~/.profile

# Program specific
export npm_config_prefix=~/.node_modules
export LD_LIBRARY_PATH=/usr/local/lib/
export MANGOHUD=0 #1 for fps in steam games
export STARDICT_DATA_DIR=$manuscripts/ingredients/dicts/dic

# Aliases
alias c="clear"
alias m="myougiden"
alias t="tango"
alias pv="pipe-viewer"
alias ron="redshift -P -O 3200 -b1"
alias roff="redshift -P -O 6200 -b1"
alias ino=arduino-cli

# Ledger cli
export LEDGER="$manuscripts/ledger/main.ledger"
alias real="ledger -f $LEDGER bal Assets --real"
alias budgets="ledger -f $LEDGER bal Budget"

# Other
if [ -f ~/.awsrc ]; then
  source ~/.awsrc
fi

export PAGER=nvimpager
