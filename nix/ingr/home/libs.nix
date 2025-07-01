{ pkgs, ...}:
{
  home.packages = with pkgs; [
    pkg-config gettext 
    autoconf automake libtool sphinx

    # network
    asio

    # different build deps
    ffmpeg tbb vulkan-headers libxkbcommon
    shared-mime-info 
    doxygen glm texinfo
    boost zlib minizip xz
    gtk3 glib.dev glibc json-glib glade
    gcc
    libffi libmediainfo libtiff
    libseccomp libnotify 
    SDL2 SDL2_ttf SDL2_net SDL2_image SDL2_sound SDL2_mixer SDL2_gfx
    openssl

    # audio
    libopus.dev opusfile.dev
    lame vips.dev
    libogg.dev
    mpg123.dev
    libsamplerate.dev
    onnxruntime.dev

    # ML
    whisper-cpp

  ];
}
