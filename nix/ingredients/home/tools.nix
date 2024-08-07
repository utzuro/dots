{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tesseract
    syncthing syncthingtray
    # android
    android-file-transfer android-tools scrcpy
    droidcam obs-studio-plugins.droidcam-obs

    usbutils

    flatpak

    fortune appimage-run

    # transfer
    filezilla libfilezilla
    rsync zsync
  ];
}
