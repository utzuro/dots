{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    monaspace
    nerdfonts font-awesome
    #powerline 
    noto-fonts noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code fira-code-symbols
    dina-font proggyfonts
  ];
}
