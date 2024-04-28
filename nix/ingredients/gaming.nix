{ pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; 
  [ 
    dosbox-staging
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    (retroarch.override {
      cores = with libretro; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw
      ];
    })
  ];
}
