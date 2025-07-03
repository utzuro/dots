{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [

    # photo
    darktable #digikam  # photo

    clipgrab 

    # other
    mediainfo-gui
  ];

}
