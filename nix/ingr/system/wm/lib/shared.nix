{ pkgs, lib, ... }:

{
  imports = [
    ./input.nix
  ];

  # Configs
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

  # Background services useful for any desktop environment
  services.power-profiles-daemon.enable = lib.mkDefault true;

  # Login
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    extraPackages = [
      pkgs.kdePackages.qt5compat
    ];

    # look
    theme = "where_is_my_sddm_theme";
    settings = {
      Theme = {
        CursorTheme = "breeze_cursors";
      };
    };
  };

  # Security
  security.pam.services = {
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  programs.seahorse.enable = true;
  # KWallet for credential storage (alternative to gnome-keyring)
  # security.pam.services.sddm.enableKwallet = true;

  # Apps useful for any desktop environment

  programs = {
    dconf.enable = true;
    foot.enable = true;
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
    libsecret
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

}
