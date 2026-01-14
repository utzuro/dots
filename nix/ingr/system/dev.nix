{ pkgs, ... }:

{
  imports =
    [
      ./lib/containers.nix
    ];

  services.flatpak.enable = true;

  xdg.portal.wlr.enable = true;

  environment.systemPackages = with pkgs; [
    # androidenv.test-suite
    # androidenv.androidPkgs.all
  ];
}

