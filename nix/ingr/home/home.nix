# USAGE
# install home-manager with
# `nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
# `nix-shell '<home-manager> -A install`
# update configs with `home-manager switch --flake .#void`

{ config, pkgs, user, inputs, ... }:

let
  homeDir = "/home/" + user.name;
in
{

  home.username = user.name;
  home.homeDirectory = homeDir;
  targets.genericLinux.enable = true;

  imports = [

    # something essential?

  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
