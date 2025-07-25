{ pkgs, ... }:

{

  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpris ];
      };
    })
  ];

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

  home.packages = with pkgs; [
    mpd mpc-cli ncmpcpp
  ];

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


    xdg.mimeApps = {
      enable = true;

      associations = {
        added = {
          "text/plain" = [ "neovide.desktop" ];
          "application/pdf" = [ "org.pwmt.zathura.desktop" ];
          "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
          "image/*" = [ "sxiv.desktop" ];
          "video/png" = [ "mpv.desktop" ];
          "video/jpg" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.desktop" ];
        };
        removed = { 
          "application/pdf" = "calibre-ebook-viewer.desktop";
          "application/epub+zip" = "calibre-ebook-viewer.desktop";
        };
      };

      defaultApplications = {
        "text/plain" = [ "neovide.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
        "image/*" = [ "sxiv.desktop" ];
        "video/png" = [ "mpv.desktop" ];
        "video/jpg" = [ "mpv.desktop" ];
        "video/*" = [ "mpv.desktop" ];
      };

    };
}
