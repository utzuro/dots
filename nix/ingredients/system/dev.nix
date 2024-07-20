{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
   android-studio-dev  # not available on home-manager
  ];
}
