# put home-manager configs here when needed
# install with `home-manager switch --flake .#void`


{ config, pkgs, user, ... }:

{
  home.username = user.name;
  home.homeDirectory = "/home/"+user.name;

  imports = [

  ];

  home.packages = [
    # core
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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".zshrc".source = ../zsh/zshrc;
  home.file.".config/i3/config".source = ../i3/config;
  #... source all the dots file like that to move to the home-manager.

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
