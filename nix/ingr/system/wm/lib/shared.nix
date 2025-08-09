{ pkgs, ... }:

{
  imports = [ 
    ./input.nix
  ];

  fonts.fontDir.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     # pkgs.xdg-desktop-portal
  #     # pkgs.xdg-desktop-portal-gtk
  #   ];
  #   config.common.default = "*";
  # };
  xdg.mime.enable = true;

  environment.systemPackages = with pkgs; [

    xdotool xdg-launch xdg-utils xsettingsd
    socat glances
    kdePackages.konsole foot kitty wezterm st
    adwaita-icon-theme

    nautilus kdePackages.dolphin xfce.thunar


    qt6.full

    (where-is-my-sddm-theme.override {
      themeConfig.General = { 
        passwordCharacter= "•";
        background = "${./login-background.jpg}"; 
        backgroundMode = "fill"; 
        showSessionsByDefault = true;
        sessionFontSize= 24;
      }; 
    })

    librewolf firefox 
    chromium qutebrowser

  ];

  programs = {

    light.enable = true;

    dconf.enable = true;

    foot = {
      enable = true;
    };

  };


  services.xserver = {
    displayManager.sessionCommands = ''  
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF  
      Xft.dpi: 100  
    EOF  
    '';
    dpi = 204;#96;
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
