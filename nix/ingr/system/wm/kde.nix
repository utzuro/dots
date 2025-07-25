{ config, lib, pkgs, ... }:

with lib;

{
  services.desktopManager = { plasma6.enable = true; };

  environment.systemPackages = with pkgs; [
    kdePackages.xwaylandvideobridge
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.packagekit-qt
    kdePackages.wayland-protocols
    kdePackages.plasma-workspace
    libportal
  ];

}
