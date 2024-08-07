{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # cli
    mpv mpd mpc-cli ncmpcpp kew
    nsxiv feh
    yt-dlp pipe-viewer clipgrab wget
    rtorrent
    obs-cli
    tuir
    libdvdcss libdvdread # dvd
    libopus libvorbis mpg123 # libs
    mediainfo 

    # gui 
    mediainfo-gui
    neovide
    zathura xournalpp
    vlc
    qbittorrent-qt5
    calibre anki pandoc
    libreoffice-fresh
    xournalpp openboard
    foliate texliveSmall

    (obsidian.override {
      commandLineArgs = 
      "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";
    })

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
