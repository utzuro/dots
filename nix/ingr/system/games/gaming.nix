{ pkgs, ... }:

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

    # linuxConsoleTools
    # jstest-gtk

    # (retroarch.withCores (cores: with cores; [
    #   genesis-plus-gx
    #   snes9x
    #   beetle-psx-hw
    # ]))

    # heroic
    # lutris adwaita-icon-theme
    # bottles
    # oversteer

    # wineWowPackages.staging winetricks
    # (wineWowPackages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })

    # (lutris.override {
    #   extraLibraries = pkgs: [
    #     # If any games are unable to run 
    #     # due to missing dependencies, 
    #     # libraries can be installed here.
    #   ];
    #   extraPkgs = pkgs: [
    #     # If any games are unable to run 
    #     # due to missing dependencies, 
    #     # pkgs can be installed here.
    #   ];
    # })

    # https://theforceengine.github.io/
    # https://github.com/JACoders/OpenJK
    # Wait for The Dark Mode to come to pkgs


    # dosbox-staging
    # dolphin-emu
    # retroarch-full
    # yabause # sega saturn
    # flycast # sega dreamcast
    # atari800

    #========================OPEN GAMES
    #===Engine Recreations
    vcmi
    fheroes2
    fallout-ce
    fallout2-ce
    openttd
    openxcom
    openmw
    exult
    openjk
    theforceengine

    #===Strategy
    wesnoth
    unciv
    mindustry-wayland #mindustry
    opendune
    zeroad
    widelands
    unvanquished

    #===Card Games
    xmage

    #===RPG
    freedink

    #===Action
    quake3e
    starsector
    yquake2-all-games
    anarch
    dxx-rebirth

    #===Lan Party
    openarena
    assaultcube
    superTuxKart

    #===MMO
    # runelite
    # runescape

    ioq3-scion
    openspades
    xonotic
    cataclysm-dda

    #===Crawl
    experienced-pixel-dungeon

    #===Space
    endless-sky

    #===Simulation
    colobot
    rigsofrods-bin
    freeorion
    flightgear

    ###########################################
    ## BUILDING ISSUES
    # warzone2100
    # devilutionx 
  ];
}
