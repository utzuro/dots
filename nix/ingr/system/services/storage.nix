{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    ensureDatabases = [ "mydatabase" ];
    enableTCPIP = true;
    port = 5430;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust
      # ... other auth rules ...

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE seeker WITH LOGIN PASSWORD 'mellon' CREATEDB;
      CREATE DATABASE archive;
      GRANT ALL PRIVILEGES ON DATABASE archive TO seeker;
    '';
    identMap = ''
      # ArbitraryMapName systemUser DBUser
         superuser_map      void      archive
         superuser_map      postgres  postgres
         # Let other names login as themselves
         superuser_map      /^(.*)$   \1
    '';
  };
}
