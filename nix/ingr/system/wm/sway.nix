{ pkgs, ...}:

{
  imports = [
    ./wayland.nix
  ];

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures.gtk = true;
  };


}
