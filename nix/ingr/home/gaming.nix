{ pkgs, inputs, ...}:

{
  home.packages = with pkgs; [

    steamcmd steam-run protontricks
    heroic lutris bottles
    adwaita-icon-theme # required for lutris
    oversteer

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

    # https://theforceengine.github.io/
    # https://github.com/JACoders/OpenJK


    dosbox-staging
  ];
}

