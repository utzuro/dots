{ pkgs, ... }:

{

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    pcsclite
    pcsc-tools
    opensc
    libnfc
    libfreefare
  ];

}
