{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # cli
    ffmpegthumbnailer 

    # images
    darktable digikam  # photo
    # gimp-with-plugins 
    krita pinta #mypaint # images
    inkscape scribus # docs

    # animation
    synfigstudio blender

    # audio
    audacity
    lmms renoise

    # video
    handbrake
    obs-studio simplescreenrecorder audio-recorder #easyeffects
    video-trimmer
    neovide vlc

    # other
    xournalpp
    qbittorrent-enhanced
    calibre pandoc
    mediainfo-gui
    libreoffice-fresh drawio
    xournalpp openboard
    foliate texliveSmall

    (obsidian.override {
      commandLineArgs = 
      "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";
    })

  ];

}
