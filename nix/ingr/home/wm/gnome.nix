# Make sure to seperate settings between wayland based gnome and X one.
{ pkgs, ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          # Put UUIDs of extensions that you want to enable here.
          # If the extension you want to enable is packaged in nixpkgs,
          # you can easily get its UUID by accessing its extensionUuid
          pkgs.gnomeExtensions.gsconnect.extensionUuid
          # Alternatively, you can manually pass UUID as a string.  
          "blur-my-shell@aunetx"
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.75;
        noise-amount = 0;
      };
      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
      };
    };
  };
}
