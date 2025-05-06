{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # output
    sl cmatrix cowsay ponysay
    
    # arcade
    ltris bastet #tetris
    ninvaders njam nsnake nudoku
    gltron moon-buggy 

    # rpg
    nethack
    angband crawl narsil 
    sil # tolkien
    brogue-ce boohu
    cataclysm-dda
    rpg-cli
    dwarf-fortress

  ];
}
