{ pkgs, ...}:

{
  home.packages = with pkgs; [
    go 
    rustup 
    python3
    php nodejs_21 
  ];
}
