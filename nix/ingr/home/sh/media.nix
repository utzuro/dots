{ pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "~/mysticism/mu";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "MPD"
      }
    '';
  };

  programs.mpv = {
    enable = true;
    bindings = {
      "ctrl+r" = "vf toggle lutyuv=y=negval";
    };
  };

  home.file.".config/ncmpcpp/config".text = ''
    def_key "l"
      next_column
    def_key "h"
      previous_column
    def_key "k"
      scroll_up
    def_key "j"
      scroll_down
    def_key "shift-k"
      select_item
      scroll_up
    def_key "shift-j"
      select_item
      scroll_down
    def_key "G"
      page_down
    def_key "g"
      page_up
    def_key "%"
      scroll_down_album
  '';

  # MIME associations are managed centrally in ../lib/mimelist.nix
  # (imported via env.nix).
}
