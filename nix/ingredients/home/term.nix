{pkgs, lib, ...}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  theme = import lib/theme {};
  inherit (theme.terminal) font fontItalic size opacity;
in {

  home.packages = (with pkgs; [
    kitty
  ]);

  programs.foot = {
    enable = true;
  };
}

