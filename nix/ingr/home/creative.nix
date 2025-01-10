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
    kdenlive handbrake
    obs-studio simplescreenrecorder audio-recorder #easyeffects
    video-trimmer
  ];

}
