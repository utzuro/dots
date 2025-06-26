{ pkgs, ...}:

{
  home.packages = with pkgs; with pkgs.jetbrains; [
    sqlitebrowser 
    dbeaver-bin pgmodeler 
    ghidra
    httpie altair
    portaudio

    # Robotics
    # mblock-mlink
    # ros2
  ];
}
