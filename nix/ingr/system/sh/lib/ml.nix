{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tesseract
    ocrmypdf

    openvino
  ];

  services.ollama = {
    enable = true;
    port = 11434;
    openFirewall = true;
    loadModels = [
    ];
  };

}
