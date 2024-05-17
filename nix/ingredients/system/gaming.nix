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
    heroic
    lutris
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
    (lutris.override {
      extraLibraries = pkgs; [
        # If any games are unable to run 
        # due to missing dependencies, 
        # libraries can be installed here.
      ];
      extraPkgs = pkgs; [
        # If any games are unable to run 
        # due to missing dependencies, 
        # pkgs can be installed here.
      ];
    };
  ];
}
