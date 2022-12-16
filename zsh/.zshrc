# Configs
source ~/.oh-my-zsh/oh-my-zsh.sh
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
#zplug "zsh-users/zsh-completions"
zplug "dracula/zsh", as:theme
zplug load
plugins=(git gitignore colored-man-pages command-not-found history zsh-interactive-cd tmux z) #zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)

# Plugin configs
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '[A' history-substring-search-up
bindkey '[B' history-substring-search-down

# Shell options
set -o vi
export VISUAL=vim
export EDITOR=vim
export DISPLAY=:0
export fpath=(~/.zsh/completion $fpath)

# PATH
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:$(du "$alchemy/scripts" | cut -f2 | sed '/.git/d' | tr '\n' ':' | sed 's/%*$//')"

# Program specific
export npm_config_prefix=~/.node_modules
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
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
