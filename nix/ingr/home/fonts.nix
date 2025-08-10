{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; with nerd-fonts; [

    # main
    hack
    dejavu_fonts # default
    go-mono
    geist-mono
    commit-mono
    inconsolata-lgc
    _0xproto

    # bitmap
    gohufont

    # compability
    wineWow64Packages.fonts
    liberation
    tinos
    arimo
    cousine
    noto

    # support
    powerline-fonts
    font-awesome
    noto-fonts-emoji
    hurmit
    hasklug
    symbols-only

    # kanji
    noto-fonts-cjk-sans

    # TODO: setup
    monaspace

  ];

}
