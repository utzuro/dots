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
    port = 11434;
    openFirewall = true;
    loadModels = [
    ];
  };

}
