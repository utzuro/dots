{ pkgs, lib, ... }:
let
  aliases = {
    c = "clear";
    vim = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";

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
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" "gitignore" 
        "colored-man-pages" 
        "command-not-found" 
        "history" 
        "zsh-interactive-cd" 
        "web-search" 
        "z" 
      ];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
   };

   initExtra = ''
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    HYPHEN_INSENSITIVE="true"
    ENABLE_CORRECTION="true"

    # Plugin configs
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
    bindkey '[A' history-substring-search-up
    bindkey '[B' history-substring-search-down

    # Shell options
    set -o vi
    export fpath=(~/.zsh/completion $fpath)
   '';
  };

  home.packages = with pkgs; [
    vim neovim 
    tmux ranger peco progress jq eza
    wget curl unzip zip 
    killall timer 
    disfetch lolcat
    ack ripgrep fzf fd bat rsync
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
    ZATHURA_PLUGINS_PATH = "/usr/lib/zathura";
    GOPATH = "$HOME/go";

    # ja input
    # QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };
}
