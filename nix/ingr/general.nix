# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ lib, pkgs, system, ... }:

{
  imports =
    [ 
      ../machines/${system.host}/hardware-configuration.nix

      ./system/system.nix
      ./system/basic.nix
      ./system/security.nix
      ./system/network.nix
      ./system/video.nix
      ./system/wm/shared.nix
      ./system/wm/i3.nix
      ./system/comms.nix

      ( import ./system/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs lib;
      })

    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
