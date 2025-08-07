{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      # to avoid fetch on shell creation
      ./system/learn.nix
      ./system/ml.nix
      ./system/creative.nix
      ./system/tools.nix
      ./system/fhs.nix
    ];
}
