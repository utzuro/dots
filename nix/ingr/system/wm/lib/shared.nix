{ pkgs, lib, ... }:

{
  imports = [
    ./input.nix
  ];

  # Configs
  fonts.fontDir.enable = true;

  services.flatpak.enable = true;
  services.dbus.packages = [
    (pkgs.writeTextDir "share/dbus-1/services/org.freedesktop.secrets.service" ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=${pkgs.kdePackages.kwallet}/bin/ksecretd
    '')
  ];

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.kdePackages.kwallet
      ];
      config.common = {
        default = "*";
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
      };
    };
    mime.enable = true;
  };

  services.xserver = {
    enable = true;
    exportConfiguration = true;

    # DPI settings (HiDPI everywhere; QT_FONT_DPI in home env.nix matches)
    dpi = 204;

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
    sddm = {
      enableGnomeKeyring = lib.mkForce false;
      kwallet.enable = true;
    };
    login = {
      enableGnomeKeyring = lib.mkForce false;
      kwallet = {
        enable = true;
        forceRun = true;
      };
    };
    swaylock = {
      text = ''
        auth include login
        auth include sddm
      '';
    };
  };
  programs.seahorse.enable = lib.mkForce false;

  environment.etc."xdg/kwalletrc".text = ''
    [Wallet]
    Enabled=true

    [org.freedesktop.secrets]
    apiEnabled=true
  '';

  # Apps useful for any desktop environment

  programs = {
    dconf.enable = true;
    foot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #basic
    kdePackages.qt5compat
    libnotify

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
    kdePackages.kwalletmanager

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
