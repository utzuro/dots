{ pkgs, ...}:

{
  services = {
    audiobookshelf.enable = true;
    calibre-server.enable = true;
  };
}
