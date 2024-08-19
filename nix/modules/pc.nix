{ config, pkgs, ... }:

{
  imports =
    [ 
      # ./system/vpn.nix
      ./system/power.nix
      ./system/nvidia.nix
      ./system/gaming.nix
    ];
}
