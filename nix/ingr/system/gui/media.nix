{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # lit
    calibre
    zathura
    pandoc

    # img
    nsxiv
    feh

    # mu
    amberol
    cantata # mpd frontend

    # audio-books
    cozy

    ## video
    vlc
    mpv

    # maps
    qgis-ltr
    viking #marble 

    # transfer
    qbittorrent-enhanced
    syncthing
    syncthingtray
    filezilla
    libfilezilla
    android-file-transfer

  ];

}
