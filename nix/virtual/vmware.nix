{ ... }:
{
  virtualisation.vmware.guest = {
    enable = true;
  };
  services.xserver.videoDrivers =
    [
      "vmware"
    ];

}
