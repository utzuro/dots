{ pkgs, ... }:

{
  services = {
    opentelemetry-collector = {
      enable = true;
    };

    grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 8880;
          enforce_domain = true;
          enable_gzip = true;
          domain = "grafana.cyber.space";

          # Alternatively, if you want to serve Grafana from a subpath:
          # domain = "your.domain";
          # root_url = "https://your.domain/grafana/";
          # serve_from_sub_path = true;
        };

        # Prevents Grafana from phoning home
        analytics.reporting_enabled = false;
      };
    };
  };
}
