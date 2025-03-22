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

  services = {
    jack.alsa.support32Bit = true;
    pipewire.alsa.support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
  (retroarch.withCores (cores: with cores; [
    genesis-plus-gx
    snes9x
    beetle-psx-hw
  ]))
];
}
