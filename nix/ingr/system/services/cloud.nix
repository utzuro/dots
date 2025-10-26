{ pkgs, ... }:

{

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.Invidious = {
    enable = true;
    port = 5599;
    openFirewall = true;
    sig-helper.enable = true;
    http3-ytproxy.enable = true;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    invidtui
  ];

  services.samba = {
    enable = true;
    openFirewall = true;
    usershares.enable = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "abyss";
        "netbios name" = "abyss";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "db" = {
        "path" = "/mnt/db";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "seeker";
        "force group" = "users";
        "valid users" = "seeker";
      };
      "portal" = {
        "path" = "/mnt/portal";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "seeker";
        "force group" = "users";
        "valid users" = "seeker";
      };
      "archivum" = {
        "path" = "/mnt/archivum";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "seeker";
        "force group" = "users";
        "valid users" = "seeker";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.avahi = {
    enable = true;
    openFirewall = true;
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
  };

  users.users.seeker = {
    extraGroups = [ "users" ];
    isNormalUser = true;
  };
  
}
