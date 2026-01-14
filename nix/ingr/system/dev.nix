{ pkgs, ... }:

{
  imports =
    [
      ./lib/containers.nix
    ];

  programs.adb.enable = true;
  services.flatpak.enable = true;

  xdg.portal.wlr.enable = true;

  environment.systemPackages = with pkgs; [
    # androidenv.test-suite
    # androidenv.androidPkgs.all
  ];
}

