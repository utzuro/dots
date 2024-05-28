{ config, pkgs, ...}:

{
  wayland.windowManager.hyprland.xwayland.enable = true;

  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [ 
    walker tofi
  ];
  # programs.walker = {
  #   enable = true;
  #   runAsService = true;
  # };
}
