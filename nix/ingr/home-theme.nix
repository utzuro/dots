{ config, pkgs, user, inputs, ... }:

{
  imports = [

    ./home/dev-gui.nix

    ./home/browser.nix
    ./home/media-gui.nix

    ./home/theme.nix

  ];
}

