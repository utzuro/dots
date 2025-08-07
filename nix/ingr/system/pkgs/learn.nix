{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    tango
    sdcv
    anki
  ];
}
