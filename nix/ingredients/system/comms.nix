{ pkgs, ...}:

{
  services.bitlbee = {
    enable = true;
    plugins = with pkgs; [
      bitlbee-discord
      bitlbee-facebook
      bitlbee-steam
    ];
  };
}
