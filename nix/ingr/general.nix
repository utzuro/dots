# install and update with 
# `sudo nixos-rebuild switch --flake .#{machine-name} --impure`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ config, lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ../machines/${system.host}/hardware-configuration.nix

      ./system/basic.nix
      ./system/system.nix
      ./system/security.nix
      ./system/network.nix

      ./system/video.nix

      ./system/wm/shared.nix

      ./system/comms.nix

      ( import ./system/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs lib;
      })

    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
