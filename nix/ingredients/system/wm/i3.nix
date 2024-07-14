{ pkgs, ... }:

{
  imports = [
    ./x11.nix
  ];

  programs.dconf.enable = true;

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        xorg.xhost
        brightnessctl xorg.xbacklight
        #bumblebee-status
        i3status i3lock i3blocks
        lxappearance
        picom
        arandr
        dunst
        libsForQt5.qt5ct
        redshift
        feh
        uim
      ];
    }; 
  };
}
