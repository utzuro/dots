# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ pkgs, ... }:

{

  imports = [
    ./core.nix
    ./lib/system.nix
    ./lib/security.nix
    ./lib/fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    # core CLI & navigation
    ranger
    zenith

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

    # networking – base
    iw
    ethtool
    wirelesstools
    wpa_supplicant
    dhcpcd
    libnatpmp
    ipcalc

    # networking – diagnostics & ops
    tcpdump
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

    # OS tooling
    nixos-generators
    zsync
  ];

}
