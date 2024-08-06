{ config, lib, pkgs, ... }:

{
  imports = [ ./fonts.nix ];
  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
  xdg.mime.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdotool
    socat
    kdePackages.konsole
  ];
}
