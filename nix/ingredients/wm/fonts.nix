{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerdfonts powerline font-awesome
    noto-fonts noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code fira-code-symbols
    dina-font proggyfonts
  ];
}
