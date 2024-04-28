{ pkgs, lib, ... }:
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
    killall timer 
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
    STARDICT_DATA_DIR = "$manuscripts/ingredients/dicts/dic";
    LEDGER = "$alchemy/manuscripts/ledger/main.ledger";
    PAGER = "nvimpager";
    MANPAGER = "nvimpager";
    ZATHURA_PLUGINS_PATH = "/usr/lib/zathura";
    GOPATH = "$HOME/go";
  };
}
