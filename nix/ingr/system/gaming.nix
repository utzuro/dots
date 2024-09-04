{ pkgs, config, ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;

  services.jack.alsa.support32Bit = true;
  services.pipewire.alsa.support32Bit = true;

  # Prepend Launch options for Steam games with:
  # - gamemode %command% too run optimizations
  # - mangohud %command% to see FPS and other info
  # - gamescope %command% to run in container
  # Or combine with
  # mangohud gamemoderun %command% OR MANGOHUD=1 gamemoderun %command%
  # Specify container parameters 
  # gamescope -W 3840 -H 2160 -r 119 -f -e -- mangohud gamemoderun %command%
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [ steam vulkan-headers ntfs3g protonup vcmi ]; 
  environment.sessionVariables = { 
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d"; # for protonup to work
  };

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        mangohud
        xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXScrnSaver
        libpng libpulseaudio libvorbis
        stdenv.cc.cc.lib libkrb5 keyutils
      ];
    };
  };
}
