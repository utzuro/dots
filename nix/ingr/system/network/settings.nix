{ system, pkgs, ... }:

{
  networking.hostName = "${system.host}";
  networking.networkmanager.enable = true;
  services.timesyncd.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; # Key-based auth only
      PermitRootLogin = "no";
    };
  };

  services.resolved.enable = true;
  networking.useDHCP = false;
  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;

  systemd.network.networks."10-e" = {
    matchConfig.Name = "e*"; # enp9s0 (10G) or enp8s0 (1G)
    networkConfig = {
      IPv6AcceptRA = true;
      DHCP = "yes";
    };
  };

  # Enable this block on hosts managed by systemd-networkd Wi-Fi.
  # systemd.network.networks."20-w" = {
  #   matchConfig.Name = "wl*";
  #   networkConfig = {
  #     DHCP = "yes";
  #   };
  # };

  networking.firewall = {
    enable = true;
    allowPing = true;

    allowedTCPPorts = [
      22 # SSH
      80 # HTTP
      443 # HTTPS
      8096 # Jellyfin HTTP
      8443 # HTTPS alt
      8920 # Jellyfin HTTPS

      # Game servers
      2302
      2303
      2304
      2305
      2306 # ARMA 3
      25565 # Minecraft
      27015 # Source engine (TF2, CS, etc.)
      34197 # Factorio
    ];

    # UDP Ports
    allowedUDPPorts = [
      # Quake/game servers
      27960
      27961
      27962
      27963

      # ARMA 3 (requires UDP!)
      2302
      2303
      2304
      2305
      2306
      # ARMA 3 Steam query
      2303

      # Source engine
      27015
      27020

      # Factorio
      34197
    ];

    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];

    trustedInterfaces = [ "lo" ];

    # Log dropped packets (useful for debugging)
    logRefusedConnections = false; # Set to true to debug
  };

  # Bluetooth
  # autosuspend causes random disconects
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=0
  '';

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; # For battery level reporting
      };
    };
  };
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    # bluetooth & wireless UI
    bluetuith
    bluetui
    overskride
  ];

}
