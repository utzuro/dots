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

  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdotool xdg-launch xdg-utils
    socat
    kdePackages.konsole foot kitty #wezterm
    glances
    xsettingsd

    (where-is-my-sddm-theme.override {
      themeConfig.General = { 
        passwordCharacter= "💀";
        background = "${./login-background.jpg}"; 
        backgroundMode = "fill"; 
        showSessionsByDefault = true;
        sessionFontSize= 24;
      }; 
    })
  ];

  programs.dconf.enable = true;

  services.xserver = {
    dpi = 204;
    enable = true;
    exportConfiguration = true;

    desktopManager.runXdgAutostartIfNone = true;
  };

  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "where_is_my_sddm_theme";
    };


}
