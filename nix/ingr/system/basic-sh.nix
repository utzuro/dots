{ pkgs, ... }:

let

  aliases = {
    update = "sudo nixos-rebuild switch";
    conf = "sudo vim /etc/nixos/configuration.nix";
    c = "clear";
    vim = "nvim";
    v = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";
    todo = "vim ~/todo";
    mpv = "mpv --alang=jpn";
    yt = "yt-dlp --no-playlist";

    # git
    upd = "git commit -am 'update' && git push";
    push = "git push";
    pull = "git pull --ff-only";
    pul = "git pull --ff-only";
    rebase = "git pull --rebase";
    force = "git push --force";
    forc = "git push --force";
    amend = "git commit --amend";

    # run apps from terminal
    # apps
    pv = "pipe-viewer";
    m = "myougiden";
    t = "tango";
    ron = "redshift -P -O 3200 -b1";
    roff = "redshift -P -O 6200 -b1";
    ino = "arduino-cli";
    real = "ledger -f $LEDGER bal Assets --real";
    budgets = "ledger -f $LEDGER bal Budget";

    ## dev
    k8s = "kubectl";
    clion = "nohup clion >/dev/null 2>&1 &";
    goland = "nohup goland >/dev/null 2>&1 &";
    pycharm = "nohup pycharm-community >/dev/null 2>&1 &";

    ## browsers
    chrome = "nohup chromium >/dev/null 2>&1 &";
    libre = "nohup librewolf >/dev/null 2>&1 &";
    firefox = "nohup firefox >/dev/null 2>&1 &";

    ## AI
    expl = "gh copilot explain ";
    sugg = "gh copilot suggest";

    # system
    open-port = "while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || { echo -e 'ERROR' ; break ; } ; sleep 45 ; done";
  };

in {

  environment.systemPackages = with pkgs; [
    vim git tmux
    ranger
    rsync
    wget curl
    file
  ];

  # users.extraUsers.void = {
  #   shell = pkgs.zsh;
  # };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;
    ohMyZsh = {
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
  };
}
