{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # cli
    ffmpegthumbnailer 

    # images
    darktable #digikam  # photo
    # gimp-with-plugins 
    krita pinta #mypaint # images
    inkscape scribus # docs

    # animation
    synfigstudio blender

    # audio
    audacity
    lmms renoise

    # music
    musescore

    # video
    handbrake
    obs-studio simplescreenrecorder audio-recorder #easyeffects
    video-trimmer

    # other
    xournalpp
    mediainfo-gui
    xournalpp openboard
    foliate texliveSmall
  ];

}
