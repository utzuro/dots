{ pkgs, ... }:

{
  system.stateVersion = "24.05";

  home-manager.config =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";
      imports = [ 
        ../ingr/home/sh.nix
      ];
    };
}
