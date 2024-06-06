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
    networkmanager-openvpn
    networkmanagerapplet
    dig tor
    openvpn protonvpn-cli wireguard-tools
  ];

  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  users.users.${user.name}.extraGroups = [ "networkmanager" ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.protonvpn = {
    enable = true;
    autostart = true;
    interface = {
      ip = "10.2.0.2";
      port = 51820;
      # privateKeyFile = "/root/secrets/pmvpn-swss.key";
      privateKeyFile = "/root/secrets/pmvpn-qk.key";
      # privateKeyFile = "/root/secrets/pmvpn-nenka.key"
      # privateKeyFile = "/root/secrets/pmvpn-tor.key"
      dns = {
        enable = true;
        ip = "10.2.0.1";
      };
    };
    endpoint = {
      port = 51820;

      #swss
      # publicKey = "U6izVBdvmWafPuKXctnvArOx6W33X8wBkMvjoOdrBhs=";
      # ip = "149.88.27.232";

      #qk
      publicKey = "d38wbEHG3sJG+0s34lCGtYU2AwZ9E/WrP3qM9gL7Xi8="; 
      ip = "37.19.205.155";

    };
  };
}
