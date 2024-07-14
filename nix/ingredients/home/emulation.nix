{ pkgs, lib, user, ...}:

{
  environment.systemPackages = with pkgs; [
    waydroid
  ];
}
