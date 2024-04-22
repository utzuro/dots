{ config, pkgs, ...}

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
}
