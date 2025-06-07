{ pkgs, lib, ...}:

{
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
  };
  xdg.portal.wlr.enable = lib.mkForce true;

  environment.systemPackages = with pkgs;
    [
      wayland
      wayland-protocols wayland-utils wlroots
      wofi wev swww
      grim grimblast slurp mako wl-clipboard swappy
      cliphist
    ];
}
