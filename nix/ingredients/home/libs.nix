{ pkgs, ...}:
{
  home.packages = with pkgs; [
    gcc gnumake cmake pkg-config gettext
    autoconf automake libtool sphinx
    ffmpeg texinfo
    gtk3 glib glibc json-glib sqlite libffi zlib libmediainfo libffi
    libseccomp girara
    shared-mime-info libnotify 
    doxygen
  ];
}
