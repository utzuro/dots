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
      ./system/lib/boot.nix
      ./system/lib/system.nix
      ./system/lib/user.nix
      ./system/lib/security.nix
    ];

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
