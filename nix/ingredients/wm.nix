{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape";
    };
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        xorg.xbacklight
        xorg.xhost
        bumblebee-status
        dmenu
        i3status
        i3lock
        i3blocks
        lxappearance
        arandr
        picom
        dunst
        libsForQt5.qt5ct
        redshift
        feh
        uim
        rofi
      ];
    }; 
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    nerdfonts
  ];

  programs.light.enable = true;

  services.xserver.libinput.enable = true;

}
