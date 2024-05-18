# put home-manager configs here when needed
# install home-manager with
# `nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
# `nix-shell '<home-manager> -A install`
# update configs with `home-manager switch --flake .#void`

{ config, pkgs, user, inputs, ... }:

let 
  homeDir = "/home/"+user.name;
in {
  home.username = user.name;
  home.homeDirectory = homeDir;

  imports = [
    ./ingredients/home/sh.nix 
    ./ingredients/home/git.nix
    ./ingredients/home/libs.nix
    ./ingredients/home/gamedev.nix
    ./ingredients/home/gaming.nix
    ./ingredients/home/comms.nix
    ./ingredients/home/media.nix
    ./ingredients/home/dev.nix
    ./ingredients/home/browser.nix
    ./ingredients/home/wm/input.nix
  ];

  home.packages = (with pkgs; [
    kitty
  ]);

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    # iconTheme = {
    #   package = gruvboxPlus;
    #   name = "GruvboxPlus";
    # };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = { 
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi;
  #   theme = ./themes/void.rasi;
  #   plugins = [ pkgs.rofi-calc ];
  # };

  # home.file.".config/i3/config".source = ../i3/config;

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
