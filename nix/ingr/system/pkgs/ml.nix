{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    tesseract
    ocrmypdf

    ollama 
    openvino

    # deps
    onnxruntime.dev
  ];
}
