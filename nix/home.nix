# put home-manager configs here when needed
# install home-manager with
# `nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
# `nix-shell '<home-manager> -A install`
# update configs with `home-manager switch --flake .#void`

{ config, pkgs, user, inputs, ... }:

{
  home.username = user.name;
  home.homeDirectory = "/home/"+user.name;

  imports = [
    ./ingredients/sh.nix
  ];

  home.packages = (with pkgs; [
    #libs
    ffmpeg texinfo
    glib libffi zlib

    # shell
    zsh
    kitty
    mpv yt-dlp pipe-viewer

    # core
    rofi
    firefox
    zathura
    chromium
    vlc

    #tools
    qbittorrent-qt5
    gimp
    inkscape
    krita
    obs-cli
    obs-studio
    libreoffice-fresh
    xournalpp
    openboard
    shared-mime-info
    foliate
    texliveSmall
    numbat


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
  ]);

  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };

  # home.file.".zshrc".source = ../zsh/zshrc;
  # home.file.".config/i3/config".source = ../i3/config;
  #... source all the dots file like that to move to the home-manager.

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
