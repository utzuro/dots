{ config, lib, pkgs, ... }:

with lib;

{
  services.xserver = {
    dpi = 98;
    enable = true;
    exportConfiguration = true;

    libinput.enable = true;

    desktopManager = {
      plasma5.enable = true;
    };

    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;

        settings = {
          Theme = {
            CursorTheme = "layan-border_cursors";

          };
        };
        theme = "breeze";
      };
      # defaultSession = "plasmawayland";
    };

    videoDrivers = [
      "fbdev" # The fbdev (Framebuffer Device) driver is a generic framebuffer driver that provides access to the frame buffer of the display hardware.
      # "modesetting"     # The modesetting driver is a generic driver for modern video hardware that relies on kernel modesetting (KMS) to set the display modes and manage resolution and refresh rate.
      # "amdgpu"          # This is the open-source kernel driver for AMD graphics cards. It's part of the AMDGPU driver stack and provides support for newer AMD GPUs.
      # "nouveau"         # Nouveau is an open-source driver for NVIDIA graphics cards. It aims to provide support for NVIDIA GPUs and is an alternative to the proprietary NVIDIA driver
    ];
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.packagekit-qt
    libportal-qt5
  ];

}
