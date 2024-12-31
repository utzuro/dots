{ pkgs, config, ... }:

{
  imports = [
    ./steam.nix
    # ./minecraft.nix
  ];

  hardware = {
    graphics.enable32Bit = true;
    steam-hardware.enable = true; 
    new-lg4ff.enable = true;
  };

  services.jack.alsa.support32Bit = true;
  services.pipewire.alsa.support32Bit = true;
}
