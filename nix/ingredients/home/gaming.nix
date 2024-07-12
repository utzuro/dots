{ pkgs, inputs, ...}:

{
  # battlenet
  home.packages = with pkgs; [

    # launchers
    steamcmd steam-run protontricks
    mangohud gamemode

    heroic lutris 
    adwaita-icon-theme # required for lutris

    openxray

    vcmi

    prismlauncher

    # wine
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    # wineWowPackages.waylandFull
    # (wineWowPackages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })
    winetricks

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

    # emulators
    dosbox-staging
    (retroarch.override {
      cores = with libretro; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw
      ];
    })

  ];
}

