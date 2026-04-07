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

    # system
    pciutils
    psmisc

    # search
    ddgr

    # calc
    bc
    numbat
    libqalculate

    # management
    ledger
    taskwarrior3
    timewarrior

    # network
    gource
    mdns
    mdns-scanner

    # net-analysis
    tshark

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

}
