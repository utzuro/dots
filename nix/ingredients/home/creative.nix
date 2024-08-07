{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # cli
    ffmpegthumbnailer 

    # images
    darktable digikam  # photo
    gimp krita mypaint pinta # images
    inkscape scribus # docs

    # animation
    synfigstudio blender

    # audio
    audacity

    # video
    kdenlive natron handbrake
    obs-studio audio-recorder easyeffects
  ];

}
