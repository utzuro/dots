# Portable system core shared by every NixOS host, including WSL and VMs.
# Desktop hardware, audio, security hardening and fonts live in basic.nix.

{ pkgs, ... }:

{

  imports = [
    ./lib/user.nix
  ];

  system.copySystemConfiguration = false;
  system.stateVersion = "26.05";

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 1024;
    "fs.inotify.max_queued_events" = 32768;
  };

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    LC_CTYPE = "en_US.UTF-8";
    LC_ADDRESS = "es_VE.UTF-8";
    LC_MEASUREMENT = "es_VE.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_MONETARY = "es_VE.UTF-8";
    LC_NAME = "es_VE.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "es_VE.UTF-8";
    LC_TELEPHONE = "es_VE.UTF-8";
    LC_TIME = "es_VE.UTF-8";
    LC_COLLATE = "es_VE.UTF-8";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
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
    duf

    # compression & archives
    gzip
    bzip2
    xz
    unzip

    # networking basics & diagnostics
    iproute2
    openssl
    wget
    wget2
    curl
    rsync
    nmap
    dig

    # user environment & OS tooling
    home-manager
    nixfmt-tree
  ];

}
