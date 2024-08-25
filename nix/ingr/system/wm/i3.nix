{ pkgs, ... }:

{
  imports = [
    ./x11.nix
  ];

  services.xserver = {
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
        kdePackages.qt6ct
        redshift
        feh
        uim
      ];
    }; 
  };
}
