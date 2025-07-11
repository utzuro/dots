{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./system/vpn.nix
      ./system/power.nix
      ./system/nvidia.nix
      ./system/gaming.nix
    ];
}
