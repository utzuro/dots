{ pkgs, ... }:

{
  system.stateVersion = "24.05";

  home-manager.config =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";
      modules = [ 
        ../ingr/home/sh.nix
      ];
      extraSpecialArgs = { inherit pkgs; };
    };
}
