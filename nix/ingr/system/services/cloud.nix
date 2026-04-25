{ pkgs, ... }:

{

  # services.netbird.clients.wt0 = {
  #   login = {
  #     enable = false; # disable autologin
  #     # setupKeyFile = "/root/secrets/netbird-main";
  #   };
  #   port = 51844;
  #   interface = "wt0";
  #   ui.enable = false;
  #   openFirewall = true;
  #   openInternalFirewall = true;
  # };
  # services.netbird.ui.enable = false;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  users.users.jellyfin.extraGroups = [ "video" "render" ];
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    ytdl-sub # YouTube subscription manager for Jellyfin
  ];

  # services.samba = {
  #   enable = true;
  #   openFirewall = true;
  #   usershares = {
  #     enable = true;
  #     group = "users";
  #   };
  #   nmbd.enable = true; # nmbd for NetBIOS name resolution
  #   settings = {
  #     global = {
  #       # Server identification
  #       "workgroup" = "WORKGROUP";
  #       "server string" = "abyss";
  #       "netbios name" = "abyss";

  #       # Security
  #       "security" = "user";
  #       "map to guest" = "bad user";
  #       "guest account" = "nobody";

  #       # Network restrictions
  #       "hosts allow" = "192.168. 10. 127.0.0.1 localhost";
  #       "hosts deny" = "0.0.0.0/0";
  #       "interfaces" = "lo enp* wlp*";
  #       "bind interfaces only" = "yes";

  #       # Performance tuning
  #       "use sendfile" = "yes";
  #       "aio read size" = "16384";
  #       "aio write size" = "16384";
  #       "min receivefile size" = "16384";

  #       # Protocol settings - SMB3 is more secure and performant
  #       "server min protocol" = "SMB2";
  #       "server max protocol" = "SMB3";
  #       "client min protocol" = "SMB2";
  #       "client max protocol" = "SMB3";

  #       # Disable printer sharing (not needed for media server)
  #       "load printers" = "no";
  #       "printing" = "bsd";
  #       "printcap name" = "/dev/null";
  #       "disable spoolss" = "yes";

  #       # Logging
  #       "log file" = "/var/log/samba/log.%m";
  #       "max log size" = "1000";
  #       "log level" = "1";
  #     };

  #     # Media database share
  #     "db" = {
  #       "path" = "/mnt/db";
  #       "comment" = "DB";
  #       "browseable" = "yes";
  #       "read only" = "yes";
  #       "guest ok" = "no";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "seeker";
  #       "force group" = "users";
  #       "valid users" = "seeker void";
  #     };

  #     # Portal share
  #     "portal" = {
  #       "path" = "/mnt/portal";
  #       "comment" = "Portal";
  #       "browseable" = "yes";
  #       "read only" = "yes";
  #       "guest ok" = "no";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "seeker";
  #       "force group" = "users";
  #       "valid users" = "seeker void";
  #     };

  #     # Archive share
  #     "archivum" = {
  #       "path" = "/mnt/archivum";
  #       "comment" = "Archivum";
  #       "browseable" = "yes";
  #       "read only" = "yes";
  #       "guest ok" = "no";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "seeker";
  #       "force group" = "users";
  #       "valid users" = "seeker void";
  #     };

  #     # Writable share for uploads (example)
  #     # "incoming" = {
  #     #   "path" = "/mnt/incoming";
  #     #   "comment" = "Incoming uploads";
  #     #   "browseable" = "yes";
  #     #   "read only" = "no";
  #     #   "guest ok" = "no";
  #     #   "create mask" = "0664";
  #     #   "directory mask" = "0775";
  #     #   "valid users" = "@users";
  #     # };
  #   };
  # };

  # SAMBA-WSDD - Web Service Discovery for Windows
  # services.samba-wsdd = {
  #   enable = true;
  #   openFirewall = true;
  #   hostname = "abyss";
  #   discovery = true; # Enable discovery mode
  # };

  # services.avahi = {
  #   enable = true;
  #   openFirewall = true;

  #   # Allow local programs to resolve .local addresses
  #   nssmdns4 = true;
  #   nssmdns6 = true;

  #   # Publish this machine's services
  #   publish = {
  #     enable = true;
  #     userServices = true;
  #     addresses = true;
  #     domain = true;
  #     workstation = true;
  #   };

  #   # Advertise additional services
  #   extraServiceFiles = {
  #     # Advertise SMB shares
  #     smb = ''
  #       <?xml version="1.0" standalone='no'?>
  #       <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
  #       <service-group>
  #         <name replace-wildcards="yes">%h</name>
  #         <service>
  #           <type>_smb._tcp</type>
  #           <port>445</port>
  #         </service>
  #       </service-group>
  #     '';
  #     # Advertise SSH
  #     ssh = ''
  #       <?xml version="1.0" standalone='no'?>
  #       <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
  #       <service-group>
  #         <name replace-wildcards="yes">%h</name>
  #         <service>
  #           <type>_ssh._tcp</type>
  #           <port>22</port>
  #         </service>
  #       </service-group>
  #     '';
  #   };
  # };

  # =============================================================================
  # SEEKER USER - For Samba access
  # =============================================================================
  users.users.seeker = {
    isNormalUser = true;
    description = "Samba and other cloud services access user";
    extraGroups = [ "users" ];
    # No login shell - only for Samba
    shell = pkgs.shadow;
  };

}
