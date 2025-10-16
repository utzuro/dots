{ pkgs, system, ... }:

{
  networking.hostName = "${system.host}";
  networking.networkmanager.enable = true;
  services.timesyncd.enable = true;

  services.openssh.enable = true;
  # services.resolved.enable = true;

  # TODO: setup wifi here

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  networking.firewall = {
    enable = false;
    allowPing = true;
    allowedUDPPorts = [ 27960 27961 27962 27963 ];
    allowedTCPPorts = [ 80 443 8443 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  environment.systemPackages = with pkgs; [
    dhcpcd
    dialog
    wpa_supplicant
    wirelesstools
  ];

  # environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
