{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./system/power-laptop.nix.nix
      ./system/gaming.nix
    ];
}
