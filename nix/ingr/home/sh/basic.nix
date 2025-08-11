{ pkgs, ... }:

{

  imports = [
    ./lib/tmux.nix
    ./lib/zsh.nix
    ./lib/lf.nix
  ];

  home.packages = with pkgs; [

    # basic
    vim
    git
    tmux
    ranger
    rsync
    wget
    curl
    file
    less

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

  programs = {
    eza = {
      enable = true;
      git = true;
      icons = "always";
    };

  };

}
