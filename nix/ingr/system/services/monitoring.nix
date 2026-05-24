{ config, pkgs, ... }:

let
  systemDashboard = pkgs.writeTextDir "system-overview.json" (
    builtins.toJSON {
      uid = "nixos-otel-system";
      title = "NixOS system via OpenTelemetry";
      tags = [
        "nixos"
        "opentelemetry"
        "prometheus"
      ];
      timezone = "browser";
      schemaVersion = 39;
      version = 1;
      refresh = "10s";
      time = {
        from = "now-1h";
        to = "now";
      };

      panels = [
        {
          id = 1;
          title = "CPU busy";
          type = "timeseries";
          datasource = {
            type = "prometheus";
            uid = "prometheus";
          };
          gridPos = {
            h = 8;
            w = 12;
            x = 0;
            y = 0;
          };
          fieldConfig = {
            defaults = {
              unit = "percent";
              min = 0;
              max = 100;
            };
            overrides = [ ];
          };
          targets = [
            {
              refId = "A";
              expr = ''100 * (1 - avg(rate(system_cpu_time_seconds_total{state="idle"}[5m])))'';
              legendFormat = "busy";
            }
          ];
        }

        {
          id = 2;
          title = "Memory used";
          type = "timeseries";
          datasource = {
            type = "prometheus";
            uid = "prometheus";
          };
          gridPos = {
            h = 8;
            w = 12;
            x = 12;
            y = 0;
          };
          fieldConfig = {
            defaults = {
              unit = "percent";
              min = 0;
              max = 100;
            };
            overrides = [ ];
          };
          targets = [
            {
              refId = "A";
              expr = ''100 * sum(system_memory_usage_bytes{state="used"}) / sum(system_memory_usage_bytes)'';
              legendFormat = "used";
            }
          ];
        }

        {
          id = 3;
          title = "Filesystem used";
          type = "timeseries";
          datasource = {
            type = "prometheus";
            uid = "prometheus";
          };
          gridPos = {
            h = 8;
            w = 12;
            x = 0;
            y = 8;
          };
          fieldConfig = {
            defaults = {
              unit = "percent";
              min = 0;
              max = 100;
            };
            overrides = [ ];
          };
          targets = [
            {
              refId = "A";
              expr = ''100 * (1 - (sum by (mountpoint) (system_filesystem_usage_bytes{state="free", mountpoint!~"/(run|dev|proc|sys).*"}) / sum by (mountpoint) (system_filesystem_usage_bytes{mountpoint!~"/(run|dev|proc|sys).*"})))'';
              legendFormat = "{{mountpoint}}";
            }
          ];
        }

        {
          id = 4;
          title = "Network IO";
          type = "timeseries";
          datasource = {
            type = "prometheus";
            uid = "prometheus";
          };
          gridPos = {
            h = 8;
            w = 12;
            x = 12;
            y = 8;
          };
          fieldConfig = {
            defaults = {
              unit = "Bps";
            };
            overrides = [ ];
          };
          targets = [
            {
              refId = "A";
              expr = "sum by (device, direction) (rate(system_network_io_bytes_total[5m]))";
              legendFormat = "{{device}} {{direction}}";
            }
          ];
        }

        {
          id = 5;
          title = "Postgres exporter up";
          type = "stat";
          datasource = {
            type = "prometheus";
            uid = "prometheus";
          };
          gridPos = {
            h = 4;
            w = 6;
            x = 0;
            y = 16;
          };
          fieldConfig = {
            defaults = {
              unit = "none";
            };
            overrides = [ ];
          };
          targets = [
            {
              refId = "A";
              expr = "pg_up";
              legendFormat = "pg_up";
            }
          ];
        }
      ];
    }
  );
in
{
  services = {
    opentelemetry-collector = {
      enable = true;

      # The default pkgs.opentelemetry-collector is enough for this simple config
      # on current upstream distributions. Switch to contrib later if you add
      # contrib-only receivers/processors/exporters.
      # package = pkgs.opentelemetry-collector-contrib;

      settings = {
        receivers = {
          hostmetrics = {
            collection_interval = "15s";
            scrapers = {
              cpu = { };
              memory = { };
              load = { };
              disk = { };
              filesystem = { };
              network = { };
            };
          };
        };

        processors = {
          batch = { };
        };

        exporters = {
          prometheus = {
            endpoint = "127.0.0.1:9464";

            # Makes resource attrs become Prometheus labels instead of only
            # appearing via target_info.
            resource_to_telemetry_conversion.enabled = true;
          };
        };

        service = {
          pipelines = {
            metrics = {
              receivers = [ "hostmetrics" ];
              processors = [ "batch" ];
              exporters = [ "prometheus" ];
            };
          };
        };
      };
    };

    prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9090;

      globalConfig.scrape_interval = "15s";

      scrapeConfigs = [
        {
          job_name = "otel-host";
          static_configs = [
            {
              targets = [ "127.0.0.1:9464" ];
            }
          ];
        }

        # Remove this scrape job if you do not run local PostgreSQL.
        {
          job_name = "postgres";
          static_configs = [
            {
              targets = [
                "127.0.0.1:${toString config.services.prometheus.exporters.postgres.port}"
              ];
            }
          ];
        }
      ];

      exporters.postgres = {
        enable = true;

        # Keep this local. No reason to expose it to your LAN for a local stack.
        listenAddress = "127.0.0.1";
        port = 9187;

        # Simple local-NixOS setup: peer-auth as the local postgres user.
        # Later, replace this with a least-privileged monitoring role.
        runAsLocalSuperUser = true;
      };
    };

    grafana = {
      enable = true;

      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 8880;

          # For direct local access / SSH tunnel:
          domain = "localhost";
          root_url = "http://localhost:8880/";
          enforce_domain = false;

          enable_gzip = true;
        };

        analytics = {
          reporting_enabled = false;
          check_for_updates = false;
          check_for_plugin_updates = false;
        };

        # On recent nixpkgs/26.05-era Grafana modules this is required.
        # For real use, make this a file/env-provider secret via sops-nix/agenix,
        # not a literal in the Nix store.
        security.secret_key = "insecure-dev-only-change-me-change-me-change-me";
      };

      provision = {
        enable = true;

        datasources.settings = {
          apiVersion = 1;
          prune = true;

          datasources = [
            {
              name = "Prometheus";
              uid = "prometheus";
              type = "prometheus";
              access = "proxy";
              url = "http://127.0.0.1:${toString config.services.prometheus.port}";
              isDefault = true;
            }
          ];
        };

        dashboards.settings = {
          apiVersion = 1;

          providers = [
            {
              name = "local-dashboards";
              type = "file";
              disableDeletion = false;
              allowUiUpdates = true;
              updateIntervalSeconds = 10;
              options.path = systemDashboard;
            }
          ];
        };
      };
    };
  };
}
