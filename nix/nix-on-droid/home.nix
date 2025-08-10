{ pkgs, ... }:

{
  system.stateVersion = "24.05";

  home-manager.config =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";
      imports = [
        ../ingr/home/sh.nix
        ../ingr/home/env.nix
        ../ingr/home/git.nix
        ../ingr/home/dev.nix
      ];
    };
}
