{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # cli
    ffmpegthumbnailer 

    # images
    darktable digikam  # photo
    gimp-with-plugins krita mypaint pinta # images
    inkscape scribus # docs

    # animation
    synfigstudio blender

    # audio
    audacity

    # video
    kdenlive handbrake
    obs-studio simplescreenrecorder audio-recorder easyeffects
    video-trimmer
  ];

}
