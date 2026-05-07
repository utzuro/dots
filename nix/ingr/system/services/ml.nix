{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tesseract
    ocrmypdf
    openvino
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    host = "127.0.0.1";
    port = 11434;
    openFirewall = true;
    loadModels = [
    ];
  };

}
