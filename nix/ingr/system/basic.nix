# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ pkgs, ... }:

{

  imports = [
    ./lib/system.nix
    ./lib/user.nix
    ./lib/security.nix
    ./lib/fonts.nix
  ];

  system.copySystemConfiguration = false;
  system.stateVersion = "26.05";

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 1024;
    "fs.inotify.max_queued_events" = 32768;
  };

  # User-facing aliases live in home-manager (nix/ingr/home/sh/lib/aliases.nix);
  # the system zsh stays alias-free.
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
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
    openssl

    # networking – diagnostics & ops
    wget
    wget2
    curl
    rsync
    nmap
    tcpdump
    dig
    speedtest-cli
    speedtest-go
    speedtest-rs
    librespeed-cli
    librespeed-rust

    # hardware testing & stress
    memtest86plus
    stressapptest

    # media tools
    mpv
    vlc
    ffmpeg
    imagemagick

    # system libraries & TUI base
    ncurses
    dialog

    # user environment & OS tooling
    home-manager
    nixos-generators
    nixfmt-tree
    zsync
  ];

}
