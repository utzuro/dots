{ ... }:

{
  services.home-assistant = {
    enable = true;
    extraPackages = ps: with ps; [ psycopg2 ];
    # config.recorder.db_url = "postgresql://@/hass";
    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

      # for the magic home devices
      "flux_led"
    ];
    config = {
      default_config = { };
      homeassistant = {
        name = "abyss";
        latitude = 35.68;
        tongitude = 139.69;
        time_zone = "Asia/Tokyo";
        unit_system = "metric";
        temperature_unit = "C";
      };
    };
  };

  # services.postgresql = {
  #   enable = false;
  #   ensureDatabases = [ "hass" ];
  #   ensureUsers = [{
  #     name = "hass";
  #     ensureDBOwnership = true;
  #   }];
  # };


}
