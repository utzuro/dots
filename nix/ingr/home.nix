# put home-manager configs here when needed
# install home-manager with
# `nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
# `nix-shell '<home-manager> -A install`
# update configs with `home-manager switch --flake .#void`

{ config, pkgs, user, inputs, ... }:

let 
  homeDir = "/home/"+user.name;
in {

  home.username = user.name;
  home.homeDirectory = homeDir;

  services.mpd = {
    enable = true;
    # link real music directory to this place"
    musicDirectory = "~/mysticism/mu"; 
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "MPD"
      }
    '';
  };

  imports = [

    ./home/sh.nix 
    ./home/env.nix 
    ./home/git.nix
    ./home/libs.nix
    ./home/tools.nix
    ./home/mimelist.nix

    ./home/theme.nix
    ./home/term.nix

    ./home/browser.nix
    ./home/comms.nix
    ./home/media.nix

    ./home/creative.nix
    ./home/dev.nix
    ./home/gamedev.nix
    ./home/emulation.nix
    ./home/gaming.nix

    ./home/wm/input.nix
    ./home/wm/ui.nix
    ./home/wm/hyprland.nix
    ./home/wm/kde.nix
    ./home/wm/i3.nix

  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
