{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland waydroid
      wayland-protocols wayland-utils wlroots
      wofi
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
        theme = "where_is_my_sddm_theme_qt5";
        package = pkgs.sddm;
      };
}
