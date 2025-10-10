{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    ## writing
    neovide
    emacs-pgtk
    (obsidian.override {
      commandLineArgs =
        "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";
    })

    # docs
    libreoffice-fresh
    scribus

    # drawing
    drawio

    # images
    gimp-with-plugins
    krita
    pinta #mypaint # images
    inkscape
    scribus # docs

    # animation
    synfigstudio
    blender

    # audio
    audacity
    lmms
    renoise
    aaxtomp3

    # music
    musescore

    # video
    handbrake
    obs-studio
    simplescreenrecorder
    audio-recorder #easyeffects
    video-trimmer

    # modeling
    freecad
    librecad

    # other
    xournalpp
    xournalpp
    openboard
    foliate
    texliveSmall
  ];

}
