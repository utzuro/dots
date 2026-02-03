{ pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    configDir = "/var/lib/hass";
    extraPackages = ps: with ps; [
      psycopg2
      numpy
    ];

    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"

      # for fast zlib compression
      "isal"

      # Common integrations
      "default_config"
      "mobile_app"
      "zeroconf"
      "ssdp"
      "flux_led" # magic home
      "esphome"
    ];

    # Note: Some settings can only be configured via the UI and are stored in
    # /var/lib/hass/.storage/ - these are NOT managed by Nix
    config = {
      default_config = { };

      homeassistant = {
        name = "abyss";
        latitude = 35.68;
        longitude = 139.69;
        time_zone = "Asia/Tokyo";
        unit_system = "metric";
        temperature_unit = "C";
        country = "JP";
        currency = "JPY";
      };

      http = {
        # UI
        server_port = 8123;
        # Uncomment if behind a reverse proxy
        # use_x_forwarded_for = true;
        # trusted_proxies = [ "127.0.0.1" "::1" ];
      };

      logger = {
        default = "info";
        # logs = {
        #   "homeassistant.components.flux_led" = "debug";
        # };
      };

      # Allows configuration from the UI
      config = { };

      # Frontend (UI)
      frontend = { };

      # Lovelace UI mode
      lovelace = {
        mode = "storage";
      };

      # Enable mobile app support
      mobile_app = { };

      # Automations, scripts, scenes stored in UI
      automation = "!include automations.yaml";
      script = "!include scripts.yaml";
      scene = "!include scenes.yaml";
    };
  };

  # Ensure the config directory exists with proper permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/hass 0750 hass hass -"
    # Create empty yaml files that HA expects (if they don't exist)
    "f /var/lib/hass/automations.yaml 0644 hass hass -"
    "f /var/lib/hass/scripts.yaml 0644 hass hass -"
    "f /var/lib/hass/scenes.yaml 0644 hass hass -"
  ];

  networking.firewall.allowedTCPPorts = [ 8123 ];
  # TODO: Make sure HA is actually using it
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "hass" ];
    ensureUsers = [{
      name = "hass";
      ensureDBOwnership = true;
    }];
  };
}
