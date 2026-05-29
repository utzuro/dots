{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    # audio & pipewire
    alsa-utils
    crosspipe
    pwvucontrol
    pavucontrol
    easyeffects
    playerctl
  ];

}
