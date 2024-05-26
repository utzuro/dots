{ config, pkgs, user, ...}:

{
  networking.hostName = "void";
  networking.networkmanager.enable = true;
  services.timesyncd.enable = true;

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;


  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
    networkmanagerapplet
    dig tor
    openvpn protonvpn-cli
  ];

  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  users.users.${user.name}.extraGroups = [ "networkmanager" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
