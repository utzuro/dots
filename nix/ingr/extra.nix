{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      # to avoid fetch on shell creation
      ./system/learn.nix
      ./system/ml.nix
      ./system/lib.nix
      ./system/gamedev.nix
      # ./system/creative.nix
      ./system/tools.nix
      ./system/fhs.nix

      ( import ./system/dev-gui.nix {
        inherit pkgs lib system;
        plugins = inputs.nix-jetbrains-plugins;
      })

    ];
}
