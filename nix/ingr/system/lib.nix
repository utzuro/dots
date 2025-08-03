{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkg-config gettext
    autoconf automake libtool sphinx

    # network
    asio

    # different build deps
    shared-mime-info 
    doxygen glm texinfo
    boost zlib minizip xz
    openssl

    # audio
    libopus.dev opusfile.dev
    lame vips.dev
    libogg.dev
    mpg123.dev
    libsamplerate.dev

    # ML
    whisper-cpp

  ];

}
