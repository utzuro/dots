{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ./lib/devtools.nix
      ./lib/gamedev.nix
      ./lib/network.nix
      ( import ./lib/jetbrains.nix {
        inherit pkgs lib system;
        plugins = inputs.nix-jetbrains-plugins;
      })
    ];

}

