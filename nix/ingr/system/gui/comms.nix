{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    signal-desktop
    discord
    vesktop
    telegram-desktop

    # try later
    # element-desktop fractal
    # threema-desktop
  ];
}
