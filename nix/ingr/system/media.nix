{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [

    # CLI

    ## docs
    w3m asciidoctor pandoc 

    ## img
    nsxiv feh
    imagemagick ffmpeg mkvtoolnix

    ## pdf
    pdftk qpdf poppler-utils 
    # recovering
    foremost

    ## audio
    mpd mpc-cli ncmpcpp kew
    cozy

    ## video
    mpv 
    yt-dlp pipe-viewer wget

    ## web
    rtorrent
    tuir

    ## legacy
    libdvdcss libdvdread # dvd

    ## other
    mediainfo 

#--------------------------------------------------------

    # GUI

    ## docs
    zathura 
    pandoc
    libreoffice-fresh drawio

    ## writing
    neovide 
    (obsidian.override {
      commandLineArgs = 
      "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";
    })

    ## video
    vlc

    ## web
    qbittorrent-enhanced

  ];
}
