{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages =
    with pkgs;
    with nerd-fonts;
    [

      # main
      hack
      dejavu_fonts # default
      go-mono
      geist-mono
      commit-mono
      inconsolata-lgc
      _0xproto
      source-sans-pro
      anonymous-pro-fonts

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
      noto-fonts-color-emoji
      hurmit
      hasklug
      symbols-only

      # kanji
      noto-fonts-cjk-sans

      # Installed for editors/terminals that opt into it.
      monaspace
    ];
}
