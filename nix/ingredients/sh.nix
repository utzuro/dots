{ pkgs, ... }:
let
  aliases = {
    c = "clear";
    vim = "nvim";
    less = "nvimpager";
    cat = "nvimpager";

    # git
    upd = "git commit -am 'update'";
    push = "git push";
    pull = "git pull --ff-only";

    # apps
    pv = "pipe-viewer";
    m = "myougiden";
    t = "tango";
    ron = "redshift -P -O 3200 -b1";
    roff = "redshift -P -O 6200 -b1";
    ino = "arduino-cli";
    real = "ledger -f $LEDGER bal Assets --real";
    budgets = "ledger -f $LEDGER bal Budget";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;
  };

  home.packages = with pkgs; [
    vim neovim nvimpager
    tmux ranger peco progress jq
    wget curl unzip zip 
    killall libnotify timer 
    disfetch lolcat
    ack ripgrep fd bat rsync tree
    w3m asciidoctor pandoc pdftk foremost
    imagemagick aaxtomp3
    htop ddgr bottom hwinfo pciutils 
    cava bc numbat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    alchemy = "$HOME/alchemy";
    manuscripts = "$alchemy/manuscripts";
    GPG_TTY = $(tty);
    npm_config_prefix = ~/.node_modules;
    LD_LIBRARY_PATH = /usr/local/lib/;
    MANGOHUD = 0 #1 for fps in steam games;
    STARDICT_DATA_DIR = $manuscripts/ingredients/dicts/dic;
    LEDGER = "$alchemy/manuscripts/ledger/main.ledger";
    PAGER = nvimpager;
    MANPAGER = "nvimpager";
    PATH = "/opt/homebrew/opt/postgresql@15/bin:$PATH";
    ZATHURA_PLUGINS_PATH = /usr/lib/zathura;
    PATH = "$PATH:$(du "$alchemy/scripts" | cut -f2 | sed '/.git/d' | tr '\n' ':' | sed 's/%*$//')";
    PATH = "$PATH:$HOME/bin";
    PATH = "$PATH:/usr/local/bin:/usr/local/sbin";
    PATH = "$PATH:/usr/local/opt/python/libexec/bin";
    GOPATH = "$HOME/go";
    PATH = "$GOROOT/bin:$PATH";
    PATH = "$PATH:$GOPATH/bin";
    PATH = "$PATH:$npm_config_prefix";
    PATH = "$PATH:$HOME/.deno/bin";
    PATH = "$PATH:$HOME/.emacs/bin";
  };

}
