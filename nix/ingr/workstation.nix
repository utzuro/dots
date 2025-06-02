{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./system/vpn.nix
      ./system/power-laptop.nix
      ./system/nvidia-hybrid.nix
      ./system/gaming.nix

      ./system/wm/hyprland.nix
      ./system/wm/sway.nix
      ./system/wm/i3.nix # also enables xmonad and xfce
      ./system/wm/kde.nix
    ];
}
