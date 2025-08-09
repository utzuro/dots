{ pkgs, ...}:

{

  home.packages = with pkgs [
    tesseract
    ocrmypdf

    ollama 
    openvino
  ];

}

