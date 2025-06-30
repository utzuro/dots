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

    # maps
    qgis-ltr marble viking

    # transfer
    filezilla libfilezilla
    rsync zsync

    # monitoring
    zenith-nvidia

    # music
    musescore

    # Create an FHS environment using the command `fhs`, 
    # enabling the execution of non-NixOS packages in NixOS!
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: 
        # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
        # lacking many basic packages needed by most software.
        # Therefore, we need to add them manually.
        #
        # pkgs.appimageTools provides basic packages required by most software.
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config gcc
          ncurses 
          vips.dev glib.dev
        ]
      );
      profile = "export FHS=1";
      runScript = "zsh";
      extraOutputsToInstall = ["dev"];
    }))
  ];
}
