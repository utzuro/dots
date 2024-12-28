{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    monaspace
    font-awesome
    #powerline 
    noto-fonts noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code fira-code-symbols
    dina-font proggyfonts
  ];
}
