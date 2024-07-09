{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland waydroid
      wayland-protocols wayland-utils wlroots
      wofi
      sddm-sugar-dark
      (where-is-my-sddm-theme.override {
        themeConfig.General = { 
          background = "${./login-background.jpg}"; 
          backgroundMode = "fill"; 
        }; 
        variants = ["qt5"]; 
      })
    ];

    services.xserver = {
      desktopManager.runXdgAutostartIfNone = true;
    };
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        theme = "sugar-dark";
        package = pkgs.sddm;
      };
}
