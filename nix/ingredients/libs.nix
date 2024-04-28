{ pkgs, ...}:
{
  home.packages = with pkgs; [
    gcc gnumake cmake
    autoconf automake libtool
    ffmpeg texinfo
    glib libffi zlib libmediainfo
    shared-mime-info
  ];
}
