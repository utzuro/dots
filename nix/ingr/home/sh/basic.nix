{ pkgs, ... }:

{

  imports = [
    ./core.nix
    ./lib/nushell.nix
    ./lib/lf.nix
  ];

  home.packages = with pkgs; [

    # basic
    ranger

    # core
    emacs
    helix
    ack
    ripgrep-all
    zsync
    moreutils
    glow
    peco
    progress
    timer
    parted

    # # media
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
    ipcalc
    nmap
    tcpdump
    dig

  ];

}
