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
    # Wait for The Dark Mode to come to pkgs


    dosbox-staging
    dolphin-emu

    # rpg
    freedink 
    ##doesn't build
    #devilutionx 
    #veloren

    # online
    runelite

    # action
    quake3e starsector
    yquake2-all-games
    anarch
    dxx-rebirth
    
    openarena ioq3-scion openspades
    unvanquished xonotic 
    assaultcube
    cataclysm-dda

    crawl  experienced-pixel-dungeon

    superTuxKart

    # space
    endless-sky pioneer flightgear
    naev 
    ## doesn't build
    #freeorion

    # strategy
    zeroad warzone2100
    wesnoth unciv
    mindustry-wayland #mindustry
    opendune widelands
    ## not building
    # colobot 

    # sim
    rigsofrods-bin

    # engine recreations
    vcmi fheroes2
    openrct2 openra
    openttd openxcom
    openmw exult
    fallout-ce fallout2-ce
    openjk theforceengine
  ];
}

