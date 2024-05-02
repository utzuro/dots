{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland waydroid
    ];

    services.xserver = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        theme = "chili";
        package = pkgs.sddm;
      };
    };
}
