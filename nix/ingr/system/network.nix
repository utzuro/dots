{ config, pkgs, system, ...}:

{
  networking.hostName = "${system.host}";
  networking.networkmanager.enable = true;
  services.timesyncd.enable = true;

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;


  environment.systemPackages = with pkgs; [
    # connection
    dhcpcd dialog wpa_supplicant 
    # analysis
    iproute2 iw ethtool libnatpmp busybox 
    ipcalc nmap tcpdump host dig 
    # vpn
    tor openvpn protonvpn-cli wireguard-tools
    networkmanager-openvpn networkmanagerapplet
    # tools
    wireshark tshark
  ];

  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
