{ pkgs, ... }:

{
  imports = [
    ./input.nix
  ];

  fonts.fontDir.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    mime.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #basic
    kdePackages.qt5compat

    # tools
    xdotool
    xdg-launch
    xdg-utils
    xsettingsd
    socat
    # glances

    # terms
    foot
    kitty
    wezterm
    alacritty
    st
    kdePackages.konsole

    # theme
    adwaita-icon-theme
    gnome-themes-extra
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        passwordCharacter = "•";
        background = "${./login-background.jpg}";
        backgroundMode = "fill";
        showSessionsByDefault = true;
        sessionFontSize = 24;
      };
    })

    # web
    qutebrowser

  ];

  programs = {

    dconf.enable = true;

    foot = {
      enable = true;
    };

  };


  services.xserver = {
    enable = true;
    exportConfiguration = true;

    # DPI settings
    dpi = 204;
    displayManager.sessionCommands = ''  
      ${pkgs.xrdb}/bin/xrdb -merge <<EOF  
      Xft.dpi: 100  
    EOF  
    '';

    desktopManager.runXdgAutostartIfNone = true;
  };

  security.pam.services = {
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    enableHidpi = true;
    extraPackages = [
      pkgs.kdePackages.qt5compat
    ];
    theme = "where_is_my_sddm_theme";
    settings = {
      General = {
        DisplayServer = "x11";
      };
    };
  };

}
