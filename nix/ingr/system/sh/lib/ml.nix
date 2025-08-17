{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tesseract
    ocrmypdf

    openvino

    python3.withPackages
    (ps: with ps; [
      torch
      torchaudio
      torchvision
    ])
  ];
}
