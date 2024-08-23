{ pkgs, inputs, ...}:

{
  # battlenet
  home.packages = with pkgs; [

    steamcmd steam-run protontricks
    heroic lutris bottles
    adwaita-icon-theme # required for lutris

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

    # openxray
    vcmi prismlauncher

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

