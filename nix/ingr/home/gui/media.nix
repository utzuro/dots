{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hakuneko
  ];
}
