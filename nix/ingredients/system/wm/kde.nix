{ config, lib, pkgs, ... }:

with lib;

{
  services.desktopManager = { plasma6.enable = true; };

  environment.systemPackages = with pkgs; [
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.packagekit-qt
    libportal
  ];

}
