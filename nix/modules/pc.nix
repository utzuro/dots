# install and update with 
# `sudo nixos-rebuild switch --flake .#system --impure`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ config, lib, pkgs, user, system, inputs, ... }:

{
  imports =
    [ 
      ../${system.host}/hardware-configuration.nix

      ./system/basic.nix
      ./system/system.nix
      ./system/power.nix
      ./system/security.nix
      ./system/network.nix
      # ./system/vpn.nix

      ./system/video.nix
      ./system/nvidia.nix
      ./system/amd.nix

      ./system/wm/shared.nix
      ./system/wm/hyprland.nix
      ./system/wm/i3.nix
      ./system/wm/kde.nix

      ./system/gaming.nix
      ./system/comms.nix

      ( import ./system/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs lib user;
      })

    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
