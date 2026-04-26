{ pkgs, lib, ... }:

{
  imports = [
    ./shared.nix
  ];
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
        auth include sddm
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };

  xdg.portal.wlr.enable = lib.mkForce true;

  environment.systemPackages = with pkgs;
    [
      wayland
      wayland-protocols
      wayland-utils
      wlroots
      wofi
      wev
      awww
      grim
      grimblast
      slurp
      mako
      wl-clipboard
      swappy
      cliphist
    ];
}
