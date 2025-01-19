{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-font-viewer
  ];

  fonts.packages = with pkgs; with nerd-fonts; [
    # main
    monaspace anonymice
    hack noto agave mplus 
    lilex lekton profont
    iosevka-term-slab zed-mono

    # programming
    go-mono blex-mono fira-mono 
    dina-font proggyfonts
    fira-code code-new-roman
    proggy-clean-tt shure-tech-mono
    geist-mono commit-mono
    _3270 _0xproto d2coding departure-mono

    # bitmap
    gohufont 

    # writing
    im-writing inconsolata-lgc
    space-mono roboto-mono intone-mono

    # compability
    wineWow64Packages.fonts
    liberation tinos arimo cousine 
    overpass mononoki 

    # symbols
    font-awesome powerline-fonts noto-fonts-emoji
    monoid hurmit hasklug symbols-only

    # special
    monofur terminess-ttf
    martian-mono open-dyslexic
    caskaydia-cove comic-shanns-mono
    fantasque-sans-mono

    # kanji
    noto-fonts noto-fonts-cjk-sans
  ];

}
