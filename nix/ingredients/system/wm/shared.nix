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
    xdotool xdg-launch xdg-utils
    socat
    kdePackages.konsole foot kitty
    glances
  ];

  services.xserver = {
    desktopManager.runXdgAutostartIfNone = true;
  };
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "where_is_my_sddm_theme_qt5";
      package = pkgs.sddm;
    };
}
