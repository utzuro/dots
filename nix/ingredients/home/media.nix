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
    audio-recorder easyeffects
    zathura calibre anki pandoc
    gimp inkscape krita
    obs-cli obs-studio
    libreoffice-fresh
    xournalpp openboard
    foliate texliveSmall

    # web
    tuir
  ];

  home.file.".config/ncmpcpp/config".text = ''
    def_key "l"
      next_column
    def_key "h"
      previous_column
    def_key "k"
      scroll_up
    def_key "j"
      scroll_down
    def_key "shift-k"
      select_item
      scroll_up
    def_key "shift-j"
      select_item
      scroll_down
    def_key "G"
      page_down
    def_key "g"
      page_up
    def_key "%"
      scroll_down_album
    '';

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "sxiv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };
}
