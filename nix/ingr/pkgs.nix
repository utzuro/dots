# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ./system/basic-sh.nix
      ./system/fonts.nix 
      ./system/rich-sh.nix
      ./system/games-sh.nix
      ./system/comms.nix
      ./system/media.nix
      ./system/dev.nix
      ( import ./system/containers.nix {
        inherit pkgs lib system;
      })

    ];

    programs.adb.enable = true;
    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [
      appimage-run
    ];

}
