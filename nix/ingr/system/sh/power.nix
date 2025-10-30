{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    mpc-cli
    ncmpcpp
    kew

    # video
    yt-dlp
    pipe-viewer

    # web
    rtorrent
    tuir
    monolith

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
    protonvpn-cli
    wireguard-tools
    networkmanager-openvpn

    # legacy
    libdvdcss
    libdvdread

    # android
    android-tools
    simple-mtpfs
    go-mtpfs
    jmtpfs

    # extra
    # woeusb
    # ventoy-full
  ];
}

