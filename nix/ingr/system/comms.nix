{ pkgs, ...}:

{
  nixpkgs.config.bitlbee.enableLibPurple = true;

  environment.systemPackages = with pkgs; [
    thelounge weechat
  ];

  services.bitlbee = {
    enable = true;
    plugins = with pkgs; [
      bitlbee-discord
      bitlbee-facebook
      bitlbee-steam
    ];
    libpurple_plugins = with pkgs; [
      purple-signald
      purple-slack
      purple-matrix
    ];
  };
}
