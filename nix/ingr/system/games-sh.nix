{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [

    # output
    sl cmatrix cowsay ponysay
    disfetch lolcat neofetch pfetch
    
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
    # dwarf-fortress

  ];
}
