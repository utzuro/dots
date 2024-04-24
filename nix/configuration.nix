{ config, lib, pkgs, user, inputs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./ingredients/system.nix
      ./ingredients/video.nix
      ./ingredients/storage.nix
      ./ingredients/network.nix
      ./ingredients/security.nix
      ./ingredients/wm.nix
      ( import ./ingredients/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs user lib;
      })
      ./ingredients/theme.nix
    ];

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=$HOME/dots/nix/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  nixpkgs.config.allowUnfree = true;

  # | Move to the Home Manager
  # v
  users.users.void = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "dialout" ];
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

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
