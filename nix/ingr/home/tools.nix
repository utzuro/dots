{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tesseract
    syncthing syncthingtray

    # android
    android-file-transfer android-tools scrcpy
    jmtpfs

    usbutils woeusb

    flatpak

    fortune appimage-run

    # files
    xfce.thunar

    # transfer
    filezilla libfilezilla
    rsync zsync

    # monitoring
    zenith-nvidia

    # music
    musescore
  ];
}
