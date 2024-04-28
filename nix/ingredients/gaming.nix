{ pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  environment.systemPackages = [ pkgs.steam ];
}
