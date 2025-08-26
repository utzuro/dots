{ pkgs, inputs, ... }:

{
  imports = [
    ./lib/game-server.nix
    # ./lib/minecraft.nix
  ];

  hardware = {
    graphics.enable32Bit = true;
    steam-hardware.enable = true;
    new-lg4ff.enable = true;
  };

  services = {
    jack.alsa.support32Bit = true;
    pipewire.alsa.support32Bit = true;
  };

  environment.systemPackages = with pkgs; [

    linuxConsoleTools
    jstest-gtk

    # (retroarch.withCores (cores: with cores; [
    #   genesis-plus-gx
    #   snes9x
    #   beetle-psx-hw
    # ]))

    steamcmd
    steam-run
    protontricks
    heroic
    lutris
    bottles
    adwaita-icon-theme # required for lutris
    oversteer

    wineWowPackages.waylandFull
    (wineWowPackages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
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
    # retroarch-full
    yabause # sega saturn
    flycast # sega dreamcast
    atari800


    # OPEN GAMES
    # rpg
    freedink
    ##doesn't build
    #devilutionx 
    #veloren

    # online
    runelite
    runescape

    # action
    quake3e
    starsector
    yquake2-all-games
    anarch
    dxx-rebirth

    openarena
    ioq3-scion
    openspades
    # unvanquished 
    xonotic
    #assaultcube
    cataclysm-dda

    crawl
    experienced-pixel-dungeon

    superTuxKart

    # space
    endless-sky
    pioneer
    naev
    ## doesn't build
    #freeorion flightgear

    # strategy
    #zeroad warzone2100
    wesnoth
    unciv
    mindustry-wayland #mindustry
    opendune
    widelands
    ## not building
    # colobot 

    # sim
    rigsofrods-bin

    # engine recreations
    vcmi #fheroes2
    # openrct2 openra
    # openttd openxcom
    # openmw exult
    #fallout-ce #fallout2-ce
    #openjk theforceengine
  ];
}
