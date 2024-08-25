{ pkgs, ...}:

{
  imports = [
    ./x11.nix
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = 
  (with pkgs; [ ]) 
  ++ (with pkgs.gnomeExtensions; [ appindicator ]) 
  ++ (with pkgs.gnome; [ ]);

  services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

  environment.gnome.excludePackages = (with pkgs; [ 
      gnome-tour gnome-connections
    ]) ++ (with pkgs.gnome; [ 
      epiphany geary evince 
    ]);
}
