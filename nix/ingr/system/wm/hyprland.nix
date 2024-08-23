{ lib, pkgs, ... }:

{
  imports = [
    ./wayland.nix
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  xdg.portal.wlr.enable = lib.mkForce true;

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment.systemPackages = with pkgs; [
    hyprland-protocols
    hyprland-workspaces hypridle
    hyprland-autoname-workspaces
    hyprland-monitor-attached
    hyprlock
    wev

    # enable eww when ready to create DIY bar
    waybar # eww
    meson ninja
    libnotify swww
    grim grimblast slurp wl-clipboard swappy
    cliphist
    hyprland-per-window-layout
  ];

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
