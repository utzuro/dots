{ inputs, ... }:

{
  imports = [ inputs.erosanix.nixosModules.protonvpn ];

  services.protonvpn = {

    enable = false;
    autostart = true;

    interface = {
      ip = "10.2.0.2";
      port = 51820;
      privateKeyFile = "/root/secrets/pmvpn-main.key";
      # privateKeyFile = "/root/secrets/pmvpn-swss.key";
      # privateKeyFile = "/root/secrets/pmvpn-qk.key";
      # privateKeyFile = "/root/secrets/pmvpn-qk-alt.key";
      # privateKeyFile = "/root/secrets/pmvpn-qk-alt2.key";
      # privateKeyFile = "/root/secrets/pmvpn-qk-alt3.key";
      # privateKeyFile = "/root/secrets/pmvpn-nenka.key"
      # privateKeyFile = "/root/secrets/pmvpn-tor.key"

      dns = {
        enable = true;
        ip = "10.2.0.1";
      };

    };

    endpoint = {

      port = 51820;

      # main
      publicKey = "IekoLP3CpczVNhssbBTXJ1SVwLbBtofVeGhqjBHRrlM=";
      ip = "37.19.205.223";

      #swss
      # publicKey = "U6izVBdvmWafPuKXctnvArOx6W33X8wBkMvjoOdrBhs=";
      # ip = "149.88.27.232";

      #qk
      # publicKey = "d38wbEHG3sJG+0s34lCGtYU2AwZ9E/WrP3qM9gL7Xi8="; 
      # ip = "37.19.205.155";

      #qk-alt #233
      # publicKey = "7FslkahrdLwGbv4QSX5Cft5CtQLmBUlpWC382SSF7Hw="; 
      # ip = "103.125.235.19";

      #qk-alt2
      # publicKey = "dMSVWPppIq7F2mVK99Le8G83r+b18Jx07spFvwmrPwg="; 
      # ip = "45.87.213.210";

      #qk-alt3 #59
      # publicKey = "IekoLP3CpczVNhssbBTXJ1SVwLbBtofVeGhqjBHRrlM="; 
      # ip = "37.19.205.223";

      #nenka
      # publicKey = "eqjhoqO6K1nLiej026+RkpSTHloVrOHLlMQaB0Tl5GM="; 
      # ip = "185.159.157.60";

      #tor
      # publicKey = "A6ZEPLYJle6Bz+dcRIX/1uNm0DRfOs47H1x8EwUeFnY="; 
      # ip = "185.159.157.176";
    };
  };
}
