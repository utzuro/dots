{ lib, pkgs, system, ... }:

{
  imports =
    [
      (import ./lib/containers.nix {
        inherit pkgs lib system;
      })
    ];

  programs.adb.enable = true;
  services.flatpak.enable = true;

  xdg.portal.wlr.enable = true;

  environment.systemPackages = with pkgs; [
    androidenv.test-suite
    # androidenv.androidPkgs.all
  ];
}

