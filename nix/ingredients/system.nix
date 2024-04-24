{ config, pkgs, ...}:

{
  time.timeZone = "Asia/Tokyo";

  hardware.enableAllFirmware = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    # use cpufreq_powersave to save power
    kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_schedutil" ];
    consoleLogLevel = 0;
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

# hardware
  sound.enable = true;
  hardware.pulseaudio.enable = true;

# battery
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

# bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # | move all non-mandotary pkgs to the Home Manager
  # V
  environment.systemPackages = with pkgs; [
    #shell
    zsh
    vim
    tmux
    git
    git-lfs
    wget
    ranger
    ack
    peco
    progress
    jq
    imagemagick
    foremost
    rsync
    tree
    zip
    unzip
    htop
    ddgr
    aaxtomp3

    #docs
    asciidoctor
    pdftk
    zathura
    calibre

    #media
    rtorrent
    mpv
    mpd
    mpc-cli
    ncmpcpp

    # dev
    go
    rustup
    php
    nodejs_21
    python3

    # learn
    anki
  ];
  

}
