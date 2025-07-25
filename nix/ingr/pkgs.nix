# install with
# `nixos-rebuild switch --flake .#{machine-name} --impure --use-remote-sudo`
# on first install enable unstable channel
# `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

{ lib, pkgs, ... }:

{
  imports =
    [ 
      ./system/sh.nix
      ./system/sh-rich.nix
      ./system/sh-games.nix
      ./system/fonts.nix 
      ./system/comms.nix
      ./system/media.nix
    ];

    programs.adb.enable = true;
    services.flatpak.enable = true;

    xdg.portal.wlr.enable = true;
    environment.systemPackages = with pkgs; [
      appimage-run
    ];

}
