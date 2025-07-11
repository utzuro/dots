{ pkgs, lib, inputs, ...}:

{
  imports = [
    inputs.hyprlux.homeManagerModules.default
  ];
  
  services = {
    swww.enable = true;
  };


  home.sessionVariables = {

    # Basic
    GDK_BACKEND = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland;xcb";

    # Fix electron apps
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    ELECTRON_FLAGS = "--enable-features=UseOzonePlatform --ozone-platform=wayland --ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";

    # Cursor
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    XCURSOR_SIZE = "32";
    HYPRCURSOR_THEME = "hyprcursor_Dracula";

    # HiDPI Scaling
    # GDK_SCALE = "1";
    # GDK_DPI_SCALE = "1";
    # QT_SCALE_FACTOR = "1";
    # PLASMA_USE_QT_SCALING = "1";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # QT_ENABLE_HIGHDPI_SCALING = "1";

    # Nvidia
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    # Memo: firefox vaapi support (config:about)
    # media.ffmpeg.vaapi.enabled = true
    # media.rdd-ffmpeg.enabled = true
    # media.av1.enabled = false
    # gfx.x11-egl.force-enabled = true
    # widget.dmabuf.force-enabled = true

  };

  wayland.windowManager.hyprland.plugins = [
    inputs.hypr-darkwindow.packages.${pkgs.system}.Hypr-DarkWindow
    inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
    pkgs.hyprlandPlugins.hyprgrass
    pkgs.hyprlandPlugins.hyprtrails
    pkgs.hyprlandPlugins.hypr-dynamic-cursors
  ];

  home.packages = with pkgs; [ 
    walker tofi foot
    wlrctl wf-recorder
    ags bun
    woomer wvkbd hyprpicker
    mpvpaper wlsunset

    hyprland-autoname-workspaces
    hyprland-monitor-attached
    hyprland-per-window-layout
  ];

  programs = {

    hyprlux = {
      enable = true;

      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };

      night_light = {
        enabled = true;
        start_time = "21:00";
        end_time = "06:00";
      };

      vibrance_configs = [
        {
          window_class = "steam_app_1172470";
          window_title = "Apex Legends";
          strength = 100;
        }
        {
          window_class = "cs2";
          window_title = "";
          strength = 100;
        }
      ];
    };

    anyrun = {
      enable = true;
      config = {
        plugins = [
        #   inputs.anyrun.packages.${pkgs.system}.applications
        #   inputs.anyrun.packages.${pkgs.system}.stdin # dmenu
        #   inputs.anyrun.packages.${pkgs.system}.dictionary
        #   inputs.anyrun.packages.${pkgs.system}.rink
        #   inputs.anyrun.packages.${pkgs.system}.shell
        #   inputs.anyrun.packages.${pkgs.system}.symbols
        #   inputs.anyrun.packages.${pkgs.system}.translate
        #   inputs.anyrun.packages.${pkgs.system}.websearch
        ];
        x = { fraction = 0.5; };
        y = { fraction = 0.3; };
        width = { fraction = 0.3; };
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = true;
        closeOnClick = true;
        showResultsImmediately = false;
        maxEntries = null;
      };
    };

    fuzzel = {
      enable = true;
      settings = lib.mkForce {
        main = {
          terminal = "${pkgs.foot}/bin/foot";
          layer = "overlay";
          dpi-aware = true;
          icon-theme = "Papirus-Dark";
          width = 40;
          font = "Hack:weight=bold:size=24";
          line-height = 40;
          # fields = "name,generic,comment,categories,filename,keywords";
          # prompt = "❯   ";
          show-actions = false;
          # exit-on-keyboard-focus-loss = true;
        };
        colors = {
          text = "FFFFFFfa";
          prompt = "FFFFFFfa";
          placeholder = "FFFFFFfa";
          selection-text= "FFFFFFfa";
          input = "FFFFFFfa";
          match = "FF00FFfa";
          selection-match = "FF00FFfa";
          counter = "FF00FFfa";
          background = "000000fa";
          selection= "8A2BE2fa";
          border = "FF00FFfa";
        };
        # dmenu.exit-immediately-if-empty = true;
      };
    };

  };
}
