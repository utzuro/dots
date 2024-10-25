{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./system/vpn.nix
      ./system/power.nix
      ./system/nvidia.nix
      ./system/gaming.nix

      ./system/wm/hyprland.nix
      ./system/wm/sway.nix
      ./system/wm/i3.nix # also enables xmonad and xfce
      ./system/wm/kde.nix
    ];
}
