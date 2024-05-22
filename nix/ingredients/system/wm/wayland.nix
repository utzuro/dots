{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland waydroid
    ];

    services.xserver = {
      desktopManager.runXdgAutostartIfNone = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        theme = "chili";
        package = pkgs.sddm;
      };
    };
}
