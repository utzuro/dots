{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # archive
    unzip
    zip
    gzip
    xz
    atool
    zstd
    lz4
    lzip
    lzo
    lzop
    rar
    unar
    p7zip

    # tools
    dysk
    lsd
    lsdvd
    ncdu
    usbutils
    aaxtomp3
    inotify-tools
    pistol
    vifm-full

    # media
    ffmpegthumbnailer
    mkvtoolnix
    mediainfo

    # docs
    w3m
    asciidoctor
    pandoc

    # pdf
    pdftk
    qpdf
    poppler-utils

    # recovery
    foremost

    # audio
    mpd
    mpc
    ncmpcpp
    kew

    # video
    yt-dlp
    pipe-viewer

    # web
    rtorrent
    tuir
    monolith
    gallery-dl

    # dict
    tango
    sdcv

    # monitoring
    zenith-nvidia
    htop
    iotop
    bottom
    hwinfo
    pciutils
    psmisc
    ddgr
    bc
    numbat
    ledger
    libqalculate
    taskwarrior3
    timewarrior

    # net-analysis
    tshark

    # vpn
    tor
    openvpn
    wireguard-tools
    networkmanager-openvpn

    # legacy
    libdvdcss
    libdvdread

    # android
    android-tools
    jmtpfs
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
