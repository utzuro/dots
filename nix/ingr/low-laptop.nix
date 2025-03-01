{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./system/power-laptop.nix
      ./system/gaming.nix

      # ./system/wm/hyprland.nix
      ./system/wm/i3.nix
    ];
}
