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

    ./home/sh.nix 
    ./home/dev.nix

    ./home/browser.nix
    ./home/media.nix

    ./home/theme.nix

    ./home/wm/hyprland.nix
    ./home/wm/i3.nix

  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
