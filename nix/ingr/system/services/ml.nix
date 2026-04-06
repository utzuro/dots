{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tesseract
    ocrmypdf

    # openvino

    # python3.withPackages
    # (ps: with ps; [
    #   torch
    #   torchaudio
    #   torchvision
    # ])
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
