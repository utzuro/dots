{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    tesseract
    ocrmypdf

    # deps
    onnxruntime.dev
  ];
}
