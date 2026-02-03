{ pkgs, ... }:

{

  services.pcscd.enable = true;

  home.packages = with pkgs; [

  ];

}
