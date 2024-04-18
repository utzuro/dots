{ config, pkgs, ...}:

{
  boot.initrd.luks.devices = {
    nixenc = {
      device = "/dev/disk/by-uuid/bda8035d-0cd2-4f97-ad26-eb124067ea6a";
      preLVM = true;
      allowDiscards = true;
    };
  };
}
