{ pkgs, ... }:

{
  # tesseract/ocrmypdf come from home-manager (home/sh/lib/ml.nix)
  environment.systemPackages = with pkgs; [
    openvino
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    # loopback only; no point opening the firewall while bound to 127.0.0.1
    host = "127.0.0.1";
    port = 11434;
    loadModels = [
    ];
  };

}
