# USAGE
# update configs with `home-manager switch --flake ~/dots#void`
# (first install: `nix run home-manager -- switch --flake ~/dots#void`)

{ pkgs, user, ... }:

let
  homeDir = "/home/" + user.name;
in
{
  home.username = user.name;
  home.homeDirectory = homeDir;
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
