{ pkgs, ...}:

{
  home.packages = with pkgs; [
    kgpg ark 
    krusader filelight 
    kate kcalc 
    kdiff3 krename 

    libarchive libbtbb libnotify notify-desktop 
    kdePackages.kweather kdePackages.kweathercore 
    kdePackages.qttools kdePackages.quazip 

    plasma-browser-integration 
  ];
}
