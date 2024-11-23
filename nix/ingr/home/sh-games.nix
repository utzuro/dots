{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # output
    sl cmatrix cowsay
    
    # games
    vitetris ltris bastet 
    ninvaders njam nsnake nudoku
    gltron moon-buggy 
    tcl2048 nethack
  ];
}
