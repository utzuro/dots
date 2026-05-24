{ pkgs, lib, ... }:

{

  imports = [
    ./shared.nix
  ];

  programs.uwsm = {
    enable = true;
    # Should be done on thy wm side already
    # waylandCompositors = {
    #   hyprland = {
    #     prettyName = "Hyprland";
    #     comment = "Hyprland compositor managed by UWSM";
    #     binPath = "/run/current-system/sw/bin/Hyprland";
    #   };
    #   sway = {
    #     prettyName = "Sway";
    #     comment = "Sway compositor managed by UWSM";
    #     binPath = "/run/current-system/sw/bin/sway";
    #   };
    # };
  };

  xdg.portal.wlr.enable = lib.mkForce true;

  environment.systemPackages = with pkgs; [
    wayland
    wayland-protocols
    wayland-utils
    wlroots
    wofi
    wev
    awww
    grim
    grimblast
    slurp
    mako
    wl-clipboard
    swappy
    cliphist
  ];
}
