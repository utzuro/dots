{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # transfer
    syncthing syncthingtray
    filezilla libfilezilla

    # android
    android-file-transfer android-tools scrcpy jmtpfs

    # maps
    qgis-ltr viking #marble 

    # extra
    woeusb # to create Windows USB installer
    ventoy-full
  ];
}
