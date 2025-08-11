{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # DB
    sqlitebrowser
    dbeaver-bin
    pgmodeler

    # Tools
    ghidra
    httpie
    altair
    portaudio

    # Robotics
    # mblock-mlink
    # ros2

    # andoird
    scrcpy

    # network
    wireshark
    networkmanagerapplet

  ];
}
