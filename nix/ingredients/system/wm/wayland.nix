{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland waydroid
      wayland-protocols wayland-utils wlroots
      ueberzugpp
      wofi
    ];

    services.xserver = {
      desktopManager.runXdgAutostartIfNone = true;
    };
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        theme = "chili";
        package = pkgs.sddm;
      };
}
