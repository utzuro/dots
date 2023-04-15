# Shell options
set -o vi
export VISUAL=vim
export EDITOR=vim

# Import system specific configurations
source ~/.profile

# Aliases
alias c="clear"
alias upd='git commit -am "update"'
alias push='git push'
alias pull='git pull --ff-only'

alias m="myougiden"
alias t="tango"

alias pv="pipe-viewer"

alias ron="redshift -P -O 3200 -b1"
alias roff="redshift -P -O 6200 -b1"

alias ino=arduino-cli

export LEDGER="$alchemy/manuscripts/ledger/main.ledger"
alias real="ledger -f $LEDGER bal Assets --real"
alias budgets="ledger -f $LEDGER bal Budget"

export PAGER=nvimpager

if [ -e /home/ssm-user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ssm-user/.nix-profile/etc/profile.d/nix.sh; fi
