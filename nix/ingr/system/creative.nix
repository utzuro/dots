{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # cli
    ffmpegthumbnailer 

    # books
    # calibre 

    # images
    # gimp-with-plugins 
    krita pinta #mypaint # images
    inkscape scribus # docs

    # animation
    synfigstudio blender

    # audio
    audacity
    lmms renoise
    aaxtomp3 

    # music
    musescore

    # video
    handbrake
    obs-studio simplescreenrecorder 
    audio-recorder #easyeffects
    video-trimmer

    # other
    xournalpp
    xournalpp openboard
    foliate texliveSmall
  ];

}
