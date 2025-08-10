{ pkgs, ... }:

let

  aliases = {
    c = "clear";
    vim = "nvim";
    v = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";
    wget = "wget2";
    mpv = "mpv --alang=jpn";
    yt = "yt-dlp --no-playlist";
    k = "ps aux | fzf | awk '{print }' | xargs -r kill -9";

    # git
    upd = "git commit -am 'minor update' && git push";
    verupd = "git commit -am 'update version' && git push";
    refactor = "git commit -am 'refactor' && git push";
    hotfix = "git commit -am 'hotfix' && git push";
    addtests = "git commit -am 'add tests' && git push";
    push = "git push";
    pull = "git pull --ff-only";
    pul = "git pull --ff-only";
    pl = "git pull --ff-only";
    rebase = "git pull --rebase";
    force = "git push --force";
    forc = "git push --force";
    amend = "git commit --amend";
    diff = "git diff --color-words";
    cached = "git diff --cached --color-words";
    changes = "git diff main --color-words";
    chmain = "git diff main --name-only";
    chmaster = "git diff main --name-only";
    chdev = "git diff main --name-only";

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

in
{
  environment.systemPackages = with pkgs; [
    # basic
    vim
    git
    tmux
    ranger
    rsync
    wget
    curl
    file

    # core
    neovim
    yazi
    ack
    ripgrep
    ripgrep-all
    fzf
    fd
    rsync
    zsync
    file
    jq
    moreutils
    wget2
    bat
    eza
    glow
    peco
    progress
    killall
    timer
    duf

    # media
    ffmpeg
    imagemagick

    # network
    dhcpcd
    dialog
    wpa_supplicant
    wirelesstools
    iproute2
    iw
    ethtool
    libnatpmp
    busybox
    ipcalc
    nmap
    tcpdump
    host
    dig
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
        "git"
        "gitignore"
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
