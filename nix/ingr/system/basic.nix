# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

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
    force = "git push --force-with-lease";
    forc = "git push --force-with-lease";
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
      ./lib/system.nix
      ./lib/user.nix
      ./lib/security.nix
      ./lib/fonts.nix
    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "26.05";

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
    # shell
    zsh
    neovim
    vim
    tmux

    # core CLI & navigation
    git
    ranger
    yazi
    fzf
    fd
    peco
    ripgrep
    ack
    bat
    eza
    glow
    jq
    moreutils
    file
    killall
    timer
    progress
    zenith
    duf

    # system introspection & power
    acpi
    lshw
    lm_sensors
    dmidecode
    hwinfo
    hw-probe
    sysbench
    msr-tools
    coppwr

    # audio & pipewire
    alsa-utils
    # crosspipe
    pwvucontrol
    pavucontrol
    easyeffects
    playerctl

    # filesystem & disks
    gparted
    gptfdisk
    e2fsprogs
    ntfs3g
    exfat
    exfatprogs

    # compression & archives
    gzip
    bzip2
    xz
    unzip

    # networking – base
    iproute2
    iw
    ethtool
    wirelesstools
    wpa_supplicant
    dhcpcd
    libnatpmp
    ipcalc

    # networking – diagnostics & ops
    wget
    wget2
    curl
    rsync
    nmap
    tcpdump
    dig
    busybox

    # bluetooth & wireless UI
    bluetuith
    bluetui
    overskride

    # hardware testing & stress
    memtest86plus
    stressapptest

    # media tools
    mpv
    ffmpeg
    imagemagick

    # system libraries & TUI base
    ncurses
    dialog

    # user environment & OS tooling
    home-manager
    nixos-generators
    zsync
  ];

}
