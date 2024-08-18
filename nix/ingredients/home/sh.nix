{ pkgs, lib, ... }:
let
  aliases = {
    c = "clear";
    vim = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";
    todo = "vim ~/todo";
    mpv = "mpv --alang=jpn";

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

    build-my-home = "home-manager switch --flake .#void --override-input home-manager ~/alchemy/summons/nixos/home-manager";

    XDG_DESKTOP_DIR = "$HOME/";
    XDG_DOWNLOAD_DIR = "$HOME/channeling";
    XDG_TEMPLATES_DIR = "$HOME/magic";
    XDG_PUBLICSHARE_DIR = "$HOME/magic";
    XDG_DOCUMENTS_DIR = "$HOME/magic";
    XDG_MUSIC_DIR = "$HOME/magic";
    XDG_PICTURES_DIR = "$HOME/magic";
    XDG_VIDEOS_DIR = "$HOME/magic";
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
        "pip" 
        "docker" 
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
    tmux zellij 
    ranger lf yazi vifm-full 
    ack ripgrep ripgrep-all fzf fd duf
    peco progress jq
    bat eza rsync
    wget curl 

    # archives
    unzip zip gzip xz atool zstd lz4 lzip lzo lzop p7zip rar rzip unar 

    # shells
    elvish xonsh

    # tools
    killall timer 
    lfs lsd lsdvd ncdu
    disfetch lolcat neofetch pfetch
    w3m asciidoctor pandoc pdftk foremost
    imagemagick ffmpeg aaxtomp3 
    htop ddgr bottom hwinfo pciutils psmisc
    cava bc numbat
    ledger bc
    inotify-tools

    taskwarrior3 tasksh geek-life
  ];

  home.sessionPath = [ "$HOME/scripts" ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    alchemy = "$HOME/alchemy";
    a = "$HOME/alchemy";
    m = "$HOME/magic";
    magic = "$HOME/magic";
    manu = "$alchemy/manuscripts";
    manuscripts = "$alchemy/manuscripts";
    STARDICT_DATA_DIR = "$manuscripts/ingredients/dicts/dic";
    LEDGER = "$HOME/alchemy/manuscripts/ledger/main.ledger";
    ZATHURA_PLUGINS_PATH = "/usr/lib/zathura";
    GOPATH = "$HOME/go";
    CHROME_EXECUTABLE="chrome";

    NIXPKGS_ALLOW_INSECURE = "1";
    NIXPKGS_ALLOW_UNFREE = "1";

    # ja input
    # QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };
}
