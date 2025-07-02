{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [

    # cli
    w3m asciidoctor pandoc 
    imagemagick ffmpeg aaxtomp3 mkvtoolnix
    pdftk qpdf poppler-utils 
    foremost # recover files
    mpd mpc-cli ncmpcpp kew
    cozy
    nsxiv feh
    yt-dlp pipe-viewer clipgrab wget
    rtorrent
    tuir
    libdvdcss libdvdread # dvd
    mediainfo 
    goread

    # gui 
    zathura 
    neovide vlc
    qbittorrent-enhanced
    calibre pandoc
    libreoffice-fresh drawio

    (obsidian.override {
      commandLineArgs = 
      "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";
    })

  ];
}
