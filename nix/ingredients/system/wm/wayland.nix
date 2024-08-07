{ pkgs, ...}:

{
  environment.systemPackages = with pkgs;
    [
      wayland
      wayland-protocols wayland-utils wlroots
      wofi
    ];
}
