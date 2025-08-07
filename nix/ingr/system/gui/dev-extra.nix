{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ./system/gamedev.nix
      ( import ./system/dev-gui.nix {
        inherit pkgs lib system;
        plugins = inputs.nix-jetbrains-plugins;
      })
    ];

}

