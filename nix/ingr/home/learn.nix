{ pkgs, ...}:
{
  home.packages = with pkgs; [
    tango
    sdcv
  ];

}
