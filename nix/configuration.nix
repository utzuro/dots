# install and update with 
# `sudo nixos-rebuild switch --flake .#system --impure`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ config, lib, pkgs, user, inputs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ( import ./ingredients/system/basic.nix {
        inherit config pkgs user;
      })
      ( import ./ingredients/system/network.nix {
        inherit config pkgs user ;
      })

      ./ingredients/system/security.nix
      ./ingredients/system/system.nix
      # ./ingredients/system/system-laptop.nix

      ./ingredients/system/video.nix
      ./ingredients/system/nvidia.nix

      ./ingredients/system/wm/fonts.nix
      ./ingredients/system/wm/i3.nix
      ./ingredients/system/wm/hyprland.nix
      # ./ingredients/system/wm/plasma.nix

      ./ingredients/system/gaming.nix

      ( import ./ingredients/system/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs user lib;
      })

    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
