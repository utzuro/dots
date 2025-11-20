{ pkgs, ... }:

# Prepend Launch options for Steam games with:
# - gamemode %command% too run optimizations
# - mangohud %command% to see FPS and other info
# - gamescope %command% to run in container
# Or combine with
# mangohud gamemoderun %command% OR MANGOHUD=1 gamemoderun %command%
# Specify container parameters 
# gamescope -W 3840 -H 2160 -r 119 -f -e -- mangohud gamemoderun %command%

{
  programs.steam = {
    enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    extraPackages = with pkgs; [
      steamcmd
      steam-tui
      steam-run
      steamback
      steam-devices-udev-rules
      mangohud
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
      protonup-ng
    ];
    protontricks.enable = true;
  };
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d"; # for protonup to work
  };
}
