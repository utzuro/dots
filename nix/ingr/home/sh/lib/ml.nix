{ pkgs, ...}:

{

  home.packages = with pkgs; [
    tesseract
    ocrmypdf

    ollama 
    # openvino # conflicts with protobuf for some reason!
  ];

}
