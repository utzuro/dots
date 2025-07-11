# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ./system/wm/shared.nix
      ./system/wm/hyprland.nix
      ./system/wm/i3.nix
      ./system/wm/sway.nix
      ./system/wm/kde.nix
    ];
}
