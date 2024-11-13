{ pkgs, ...}:

{
  nixpkgs.config.bitlbee.enableLibPurple = true;

  environment.systemPackages = with pkgs; [
    thelounge weechat
  ];

  services = [
    matrix-conduit = {
      enable = true;
      settings.global = {
        allow_registration = false; # make true to create user
        address = "::1";
        database_backend = "rocksdb";
# For VoIP see https://docs.conduit.rs/turn.html, and https://github.com/element-hq/synapse/blob/develop/docs/turn-howto.md for more details
      # turn_uris = [
      #  "turn:your.turn.url?transport=udp"
      #  "turn:your.turn.url?transport=tcp"
      # ];
      # turn_secret = "your secret";
    bitlbee = {
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
  ]
}
