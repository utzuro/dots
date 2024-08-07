{ pkgs, ...}:

{
  home.packages = with pkgs; [
    kgpg ark 
    krusader filelight 
    kate kcalc 
    kdiff3 krename 

    libarchive libbtbb libnotify notify-desktop 
    libsForQt5.kweather libsForQt5.kweathercore 
    libsForQt5.qt5.qttools libsForQt5.quazip 

    plasma-browser-integration 
  ];
}
