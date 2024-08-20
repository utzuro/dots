{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./system/power-laptop.nix
      ./system/gaming.nix
    ];
}
