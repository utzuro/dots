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
    yt = "yt-dlp";

    # git
    upd = "git commit -am 'update' && git push";
    push = "git push";
    pull = "git pull --ff-only";
    rebase = "git pull --rebase";
    force = "git push --force";
    amend = "git commit --amend";

    # apps
    pv = "pipe-viewer";
    m = "myougiden";
    t = "tango";
    ron = "redshift -P -O 3200 -b1";
    roff = "redshift -P -O 6200 -b1";
    ino = "arduino-cli";
    real = "ledger -f $LEDGER bal Assets --real";
    budgets = "ledger -f $LEDGER bal Budget";

    # run apps from terminal
    ## dev
    k8s = "kubectl";
    clion = "nohup clion >/dev/null 2>&1 &";
    goland = "nohup goland >/dev/null 2>&1 &";
    pycharm = "nohup pycharm-community >/dev/null 2>&1 &";
    ## browsers
    chrome = "nohup chromium >/dev/null 2>&1 &";
    libre = "nohup librewolf >/dev/null 2>&1 &";
    firefox = "nohup firefox >/dev/null 2>&1 &";

    MY_HOMEMANAGER = "~/alchemy/summons/nixos/home-manager";
    build-my-home = "./ingr/cleanup && home-manager switch --flake .#void --impure";  #--override-input home-manager ~/alchemy/summons/nixos/home-manager --impure";
    open-port = "while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || { echo -e 'ERROR' ; break ; } ; sleep 45 ; done";

    XDG_DESKTOP_DIR = "$HOME/";
    XDG_DOWNLOAD_DIR = "$HOME/channeling";
    XDG_TEMPLATES_DIR = "$HOME/magic";
    XDG_PUBLICSHARE_DIR = "$HOME/magic";
    XDG_DOCUMENTS_DIR = "$HOME/magic";
    XDG_MUSIC_DIR = "$HOME/magic";
    XDG_PICTURES_DIR = "$HOME/magic";
    XDG_VIDEOS_DIR = "$HOME/magic";
  };

in {
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
}
