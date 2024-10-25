{ pkgs, config, ... }:

{
  imports = [
    ./steam.nix
    # ./minecraft.nix
  ];

  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;

  services.jack.alsa.support32Bit = true;
  services.pipewire.alsa.support32Bit = true;
}
