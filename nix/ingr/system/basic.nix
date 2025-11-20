# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ lib, pkgs, system, inputs, ... }:

let

  aliases = {
    c = "clear";
    vim = "nvim";
    v = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";
    wget = "wget2";
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

    open-port = "while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || { echo -e 'ERROR' ; break ; } ; sleep 45 ; done";
  };

in
{

  imports =
    [
      ../machines/${system.host}/hardware-configuration.nix

      # config
      ./lib/boot.nix
      ./lib/system.nix
      ./lib/user.nix
      ./lib/security.nix
      ./lib/fonts.nix
    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";

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
    dig

    # OS
    exfat
    exfatprogs
  ];
}
