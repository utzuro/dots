{ pkgs, lib, ...}:

{

  environment.systemPackages = with pkgs; [ 
    meson ninja libnotify 
  ]; 

}
