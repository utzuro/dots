# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./configs/low.nix
      ./configs/storage.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# battery
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "void-x240";
  networking.wireless = {
    enable = true; 
    userControlled.enable = true; 
    networks = {
      "nihonbu-guest".psk = "nihonbuingakakkoii";
    };
  };

  time.timeZone = "Asia/Tokyo";

  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape";
    };
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        xorg.xbacklight
        xorg.xhost
        bumblebee-status
        dmenu
        i3status
        i3lock
        i3blocks
        lxappearance
        arandr
        picom
        dunst
        libsForQt5.qt5ct
        redshift
        feh
        uim
        rofi
      ];
    }; 
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    nerdfonts
  ];

  programs.light.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.libinput.enable = true;

  users.users.void = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kitty
      neovim
      nvimpager
      firefox
      chromium
      vlc
      yt-dlp
      pipe-viewer

      #tools
      qbittorrent-qt5
      gimp
      inkscape
      krita
      obs-cli

      # chats
      signal-desktop
      signald
      signaldctl
      signal-cli
      webcord
      telegram-desktop

      #wayland
      #wineWowPackages.waylandFull

      #gaming
      dosbox-staging
      wineWowPackages.staging
      winetricks
      (retroarch.override {
        cores = with libretro; [
          genesis-plus-gx
          snes9x
          beetle-psx-hw
        ];
      })
    ];
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

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

    #network
    tor
    protonvpn-cli
    openvpn

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
    docker
    docker-compose
    virtualbox
    go
    rustup
    php
    nodejs_21
    python3

    # learn
    anki
  ];
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      conf = "sudo vim /etc/nixos/configuration.nix";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Don't change
  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
