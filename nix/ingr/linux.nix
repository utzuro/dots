# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ../machines/${system.host}/hardware-configuration.nix

      # config
      ./system/system.nix
      ./system/user.nix
      ./system/security.nix
      ./system/video.nix
      ./system/virtualization.nix
    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
