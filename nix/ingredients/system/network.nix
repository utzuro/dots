{ config, pkgs, user, system, ...}:

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
    dhcpcd dialog nmcli wpa_supplicant 
    iproute2 iw ethtool 
    ipcalc nmap tcpdump host dig
    networkmanager-openvpn
    networkmanagerapplet
    tor openvpn protonvpn-cli wireguard-tools
  ];

  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  users.users.${user.name}.extraGroups = [ "networkmanager" ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
