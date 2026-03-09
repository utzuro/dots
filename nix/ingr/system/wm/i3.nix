{ pkgs, ... }:

{
  imports = [
    ./lib/x.nix
  ];

  services.xserver = {

    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = false;
      };

    };

    windowManager = {

      i3 = {
        enable = true;
        extraPackages = with pkgs; [
          xhost
          xbacklight
          xinit
          picom
          brightnessctl
          bumblebee-status
          i3lock
          lxappearance
          arandr
          dunst
          redshift
          rofi
          feh
        ];
      };

      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      };
    };

  };
}
