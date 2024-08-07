{ pkgs, ...}:

{
  home.packages = with pkgs; [

      kgpg                            # A KDE based interface for GnuPG, a powerful encryption utility
      ark                             # Graphical file compression/decompression utility
      krusader                        # Advanced twin panel (commander style) file manager
      filelight                       # Disk usage statistics
      kate                            # Advanced text editor
      kcalc                           # Scientific calculator
      kdiff3                          # Compares and merges 2 or 3 files or directories
      krename                         # A powerful batch renamer for KDE
      libsForQt5.kweather             # Weather application for Plasma Mobile
      libsForQt5.kweathercore         # Library to facilitate retrieval of weather information including forecasts and alerts 
      libsForQt5.qt5.qttools          # A cross-platform application framework for C++
                                        # qhelpgenerator linguist qtplugininfo qdistancefieldgenerator pixeltool
                                        # qcollectiongenerator assistant qtdiag qdbusviewer lupdate qtpaths
                                        # qtattributionsscanner lconvert designer lupdate-pro lrelease qdbus lprodump lrelease-pro

      libsForQt5.quazip               # Provides access to ZIP archives from Qt 5 programs
# quazip


      libarchive                      # bsdtar bsdcpio bsdcat
      libbtbb                         # Bluetooth baseband decoding library
      libnotify                       # Desktop Notify agent example: notify-send --icon=fcitx --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
      notify-desktop                  # Desktop Notify agent example: notify-desktop --icon=call-start "Incoming call"   SOURCE: https://github.com/nowrep/notify-desktop/tree/master

      plasma-browser-integration
  ];
}
