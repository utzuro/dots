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
    ./home/git.nix
    ./home/libs.nix
    ./home/gamedev.nix
    ./home/gaming.nix
    ./home/wm/ui.nix
    ./home/wm/hyplrand.nix
    ./home/comms.nix
    ./home/vpn.nix
    ./home/media.nix
    ./home/dev.nix
    ./home/browser.nix
    ./home/wm/input.nix
    # ./home/wm/i3.nix
  ];

  home.packages = (with pkgs; [
    kitty
  ]);

  stylix.image = ./i/background.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = ./theme.yaml;

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
