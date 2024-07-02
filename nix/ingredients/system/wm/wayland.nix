{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland waydroid
      wayland-protocols wayland-utils wlroots
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
