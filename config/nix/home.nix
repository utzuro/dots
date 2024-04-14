# put home-manager configs here when needed
# install with `home-manager switch --flake .#void`


{ config, pkgs, ... }:

{
  home.username = "void";
  home.homeDirectory = "/home/void";

  home.stateVersion = "23.11";

  home.packages = [

  ]

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
