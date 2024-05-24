{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # cli
    mpv mpd mpc-cli ncmpcpp 
    yt-dlp pipe-viewer
    rtorrent
    mediainfo

    # gui
    neovide obsidian
    vlc mpv
    qbittorrent-qt5
    audio-recorder
    zathura calibre anki
    gimp inkscape krita
    obs-cli obs-studio
    libreoffice-fresh
    xournalpp openboard
    foliate texliveSmall

    # web
    tuir
  ];

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "sxiv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };
}
