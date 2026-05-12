{ pkgs, ... }:

let
  gog = pkgs.writeShellApplication {
    name = "gog";
    runtimeInputs = with pkgs; [
      umu-launcher
      coreutils
    ];

    text = ''
      set -euo pipefail

      if [ "$#" -lt 2 ]; then
        echo "usage: gog <prefix-name> <exe-or-installer> [args...]" >&2
        exit 2
      fi

      prefix_name="$1"
      shift

      export WINEPREFIX="''${WINEPREFIX:-$HOME/darkarts/lib/prefixes/$prefix_name}"
      export STORE="''${STORE:-gog}"
      export GAMEID="''${GAMEID:-umu-default}"

      export PROTONPATH="''${PROTONPATH:-GE-Proton}"

      mkdir -p "$WINEPREFIX"
      exec umu-run "$@"
    '';
  };
in
{

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

    #========================LANUCHERS
    gog
    steam-run
    heroic
    lutris
    bottles
    adwaita-icon-theme # dep

    wineWow64Packages.staging
    winetricks
    (wineWow64Packages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
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

    #========================TOOLS
    oversteer
    mangohud
    gamescope
    lgogdownloader
    linuxConsoleTools
    jstest-gtk

    #========================EMU
    scummvm
    dosbox-staging

    retroarch-full
    # specify cores if full fails
    # (retroarch.withCores (cores: with cores; [
    #   genesis-plus-gx
    #   snes9x
    #   beetle-psx-hw
    # ]))
    ppsspp
    dolphin-emu
    yabause # sega saturn
    flycast # sega dreamcast
    atari800
    ryubing

    moonlight-qt

    #========================OPEN GAMES
    # https://theforceengine.github.io/
    # https://github.com/JACoders/OpenJK
    # Wait for The Dark Mode to come to pkgs

    #===Engine Recreations
    # vcmi
    # fheroes2
    # fallout-ce
    # fallout2-ce
    # openttd
    # openxcom
    # openmw
    # exult
    openjk
    theforceengine

    #===Strategy
    wesnoth
    unciv
    mindustry-wayland #mindustry
    opendune
    zeroad
    unvanquished

    #===Card Games
    # xmage

    #===RPG
    # freedink

    #===Action
    # quake3e
    # starsector
    # yquake2-all-games
    # anarch
    # dxx-rebirth

    #===Lan Party
    openarena
    assaultcube
    supertuxkart

    #===MMO
    # runelite
    # runescape

    # ioq3-scion
    # openspades
    # xonotic
    # cataclysm-dda

    #===Crawl
    experienced-pixel-dungeon

    #===Space
    endless-sky

    #===Simulation
    # colobot
    # rigsofrods-bin
    freeorion
    flightgear

    ###########################################
    ## BUILDING ISSUES
    # warzone2100
    # devilutionx 
  ];

  programs.firejail.wrappedBinaries = {
    steam = {
      executable = "${pkgs.steam}/bin/steam";
      profile = "${pkgs.firejail}/etc/firejail/steam.profile";
    };
    steam-run = {
      executable = "${pkgs.steam}/bin/steam-run";
      profile = "${pkgs.firejail}/etc/firejail/steam.profile";
    };
    prismlauncher = {
      executable = "${pkgs.prismlauncher}/bin/prismlauncher";
      profile = ./firejail-profiles/prismlauncher.profile;
    };
  };
}
