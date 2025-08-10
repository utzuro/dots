{ config, pkgs, system, ... }:

{
  environment.systemPackages = with pkgs; [

    # vpn
    networkmanager-openvpn
    networkmanagerapplet

    # tools
    wireshark
    tshark

  ];
}
