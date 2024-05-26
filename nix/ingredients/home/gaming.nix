{ pkgs, ...}:

{
  # battlenet
  home.packages = with pkgs; [

    steamcmd steam-run
    mangohud gamemode

    heroic lutris 

    vcmi

    wineWowPackages.waylandFull
    # (wineWowPackages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })
    winetricks

    dosbox-staging
    (retroarch.override {
      cores = with libretro; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw
      ];
    })
    (lutris.override {
      extraLibraries = pkgs: [
        # If any games are unable to run 
        # due to missing dependencies, 
        # libraries can be installed here.
      ];
      extraPkgs = pkgs: [
        # If any games are unable to run 
        # due to missing dependencies, 
        # pkgs can be installed here.
      ];
    })
  ];
}

