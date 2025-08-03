{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # CLI
    mpd mpc-cli ncmpcpp
    sxiv feh

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
    yt-dlp pipe-viewer wget2

    ## web
    rtorrent tuir monolith

    ## legacy
    libdvdcss libdvdread # dvd

    ## other
    mediainfo 

#---------------------------------------------------

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

  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpris ];
      };
    })
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "~/mysticism/mu"; 
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "MPD"
      }
    '';
  };

  programs.mpv = {
    enable = true;
    bindings = {
      "ctrl+r" = "vf toggle lutyuv=y=negval";
    };
  };

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


    xdg.mimeApps = {
      enable = true;

      associations = {
        added = {
          "text/plain" = [ "neovide.desktop" ];
          "application/pdf" = [ "org.pwmt.zathura.desktop" ];
          "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
          "image/*" = [ "sxiv.desktop" ];
          "video/png" = [ "mpv.desktop" ];
          "video/jpg" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.desktop" ];
        };
        removed = { 
          "application/pdf" = "calibre-ebook-viewer.desktop";
          "application/epub+zip" = "calibre-ebook-viewer.desktop";
        };
      };

      defaultApplications = {
        "text/plain" = [ "neovide.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
        "image/*" = [ "sxiv.desktop" ];
        "video/png" = [ "mpv.desktop" ];
        "video/jpg" = [ "mpv.desktop" ];
        "video/*" = [ "mpv.desktop" ];
      };

    };
}
