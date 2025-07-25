{ config, pkgs, system, ...}:

{
  environment.systemPackages = with pkgs; [
    # connection
    dhcpcd dialog wpa_supplicant wirelesstools
    # analysis
    iproute2 iw ethtool libnatpmp busybox 
    ipcalc nmap tcpdump host dig 
    # vpn
    tor openvpn protonvpn-cli wireguard-tools
    networkmanager-openvpn networkmanagerapplet
    # tools
    wireshark tshark
  ];
}
