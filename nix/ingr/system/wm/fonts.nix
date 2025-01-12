{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-font-viewer
  ];

  imports = [
    { 
      fonts.packages = with pkgs; [
        # programming
        dina-font proggyfonts

        # kanji
        noto-fonts noto-fonts-cjk-sans

        # symbols
        font-awesome
        powerline-fonts
        noto-fonts-emoji

        # compability
        wineWow64Packages.fonts
      ];
    }

    {
      fonts.packages = with pkgs.nerd-fonts; [
        # main
        monaspace anonymice
        hack noto agave mplus 
        lilex lekton profont
        iosevka-term-slab zed-mono

        # programming
        go-mono blex-mono fira-mono 
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
        liberation tinos arimo cousine 
        overpass mononoki 

        # symbols
        monoid hurmit hasklug symbols-only

        # special
        monofur terminess-ttf
        martian-mono open-dyslexic
        caskaydia-cove comic-shanns-mono
        fantasque-sans-mono
      ];
    }
  ];
}
