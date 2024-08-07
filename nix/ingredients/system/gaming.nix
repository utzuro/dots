{ pkgs, config, ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;

  services.jack.alsa.support32Bit = true;
  services.pipewire.alsa.support32Bit = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [ steam gamescope vulkan-headers ntfs3g ];
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
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
      ];
    };
  };
}
