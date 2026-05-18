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
      mangohud
      libXcursor
      libXi
      libXinerama
      libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
    protontricks.enable = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    steam-run
    protonup-ng
    steamcmd
    steam-tui
    steamback
    steam-devices-udev-rules
    game-devices-udev-rules
    SDL2
  ];

  hardware.steam-hardware.enable = true;
  hardware.uinput.enable = true;
  services.udev.packages = with pkgs; [
    steam-devices-udev-rules
    game-devices-udev-rules
  ];
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c24f", GROUP="input", MODE="0660", TAG+="uaccess"
  '';

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d"; # for protonup to work
  };
}
