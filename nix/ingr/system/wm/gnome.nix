{ pkgs, lib, ... }:

{
  imports = [
    ./lib/x.nix
  ];

  services = {
    displayManager.gdm.enable = false;
    desktopManager.gnome.enable = false;
  };

  environment.systemPackages =
    (with pkgs; [ ])
    ++ (with pkgs.gnomeExtensions; [ appindicator ])
    ++ (with pkgs.gnome; [ ]);

  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    epiphany
    geary
    evince
  ]) ++ (with pkgs.gnome; [ ]);

  # Avoid conflicts between different desktop environments
  programs.seahorse.enable = lib.mkForce false;

}
