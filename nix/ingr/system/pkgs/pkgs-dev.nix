{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ./system/dev.nix
      ./system/ml.nix
      ( import ./system/containers.nix {
        inherit pkgs lib system;
      })
    ];

    programs.adb.enable = true;
    services.flatpak.enable = true;

    xdg.portal.wlr.enable = true;
    environment.systemPackages = with pkgs; [
      appimage-run
    ];

}

