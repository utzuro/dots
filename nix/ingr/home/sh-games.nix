{ pkgs, ...}:

{
  home.packages = with pkgs; [
    sl cmatrix cowsay
  ];
}
