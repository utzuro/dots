{ config, pkgs, ...}:

{
  networking.hostName = "void-x240";
  networking.wireless = {
    enable = true; 
    userControlled.enable = true; 
    networks = {
      "nihonbu-guest".psk = "nihonbuingakakkoii";
    };
  };
  services.timesyncd.enable = true;

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;


  environment.systemPackages = with pkgs; [
    dig
    tor
    openvpn
    protonvpn-cli
  ];

  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
