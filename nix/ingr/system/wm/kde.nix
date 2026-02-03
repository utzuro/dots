{ lib, pkgs, ... }:

{
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true; # support older apps
  };

  # Use KDE's portal for better integration
  xdg.portal = {
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    # Let KDE portal handle KDE apps, GTK portal handle GTK apps
    config = {
      kde = {
        default = [ "kde" "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };

  services.displayManager = {
    defaultSession = lib.mkDefault "plasma"; # Wayland session
    # Use "plasmax11" for X11 session if Wayland has issues
  };

  environment.systemPackages = with pkgs.kdePackages; [
    # Wayland support
    xwaylandvideobridge # Screen sharing in X11 apps on Wayland
    wayland-protocols
    plasma-workspace
    plasma-integration # Better Qt app integration

    # Account integration
    kaccounts-integration
    kaccounts-providers
    signond # SSO daemon for accounts

    # System tools
    packagekit-qt # Software updates
    ksystemstats # System monitoring
    plasma-systemmonitor # System monitor app
    kinfocenter # System information
    partitionmanager # Disk management
    filelight # Disk usage visualization

    # KDE applications (essentials)
    dolphin # File manager
    dolphin-plugins
    ark # Archive manager
    spectacle # Screenshots
    gwenview # Image viewer
    okular # Document viewer
    kate # Text editor
    kcalc # Calculator
    kcharselect # Character picker

    # Networking
    plasma-nm # NetworkManager applet
    kdeconnect-kde # Phone integration

    # Multimedia
    plasma-pa # PulseAudio/PipeWire applet
    elisa # Music player (optional)

    # Appearance
    breeze-icons
    oxygen-icons

    # Portal support
    xdg-desktop-portal-kde
  ] ++ (with pkgs; [
    # Non-KDE but useful with Plasma
    libportal # Portal library
    libportal-qt6 # Qt6 portal bindings
  ]);

  # KDE Connect (phone integration)
  # programs.kdeconnect.enable = true;
  # Note: Opens firewall ports 1714-1764 TCP/UDP automatically

  # Ensure GTK apps respect KDE theme settings
  programs.dconf.enable = true;
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  environment.sessionVariables = {
    # Better file picker in Firefox/Electron apps
    GTK_USE_PORTAL = "1";
    # Ensure Qt apps use Wayland (with X11 fallback)
    QT_QPA_PLATFORM = "wayland;xcb";
    # KDE Wallet for credential storage (uncomment if using ksshaskpass)
    # SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    # SSH_ASKPASS_REQUIRE = "prefer";
  };
  # KWallet for credential storage (alternative to gnome-keyring)
  # security.pam.services.sddm.enableKwallet = true;

  services.power-profiles-daemon.enable = lib.mkDefault true;

  services.displayManager.sddm = {
    wayland.enable = lib.mkDefault true;
    # Use Breeze theme for KDE consistency (overridable by custom theme in shared.nix)
    theme = lib.mkDefault "breeze";
    settings = {
      Theme = {
        CursorTheme = "breeze_cursors";
      };
    };
  };
}
