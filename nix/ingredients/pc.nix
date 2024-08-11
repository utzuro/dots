# install and update with 
# `sudo nixos-rebuild switch --flake .#system --impure`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ config, lib, pkgs, user, system, inputs, ... }:

{
  imports =
    [ 
      ../${system.host}/hardware-configuration.nix

      ( import ./system/basic.nix {
        inherit config pkgs user;
      })

      ( import ./system/network.nix {
        inherit config pkgs user system;
      })

      ( import ./system/system.nix {
        inherit config pkgs user system;
      })

      ./system/comms.nix
      # ./system/vpn.nix
      ./system/security.nix
      ./system/power.nix
      ./system/video.nix
      ./system/nvidia.nix

      ./system/wm/shared.nix
      ./system/wm/i3.nix
      ./system/wm/hyprland.nix
      ./system/wm/kde.nix

      ./system/gaming.nix

      ( import ./system/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs user lib;
      })

    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
