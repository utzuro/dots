{ pkgs, user, ... }:

{
  stylix = {

    targets = {
      firefox.profileNames = [ user.name ];
    };

    enable = true;

    polarity = "dark";
    base16Scheme = ./lib/theme.yaml;
    image = ./lib/i/background.jpg;

    opacity = {
      applications = 0.8;
      desktop = 0.8;
      popups = 0.8;
      terminal = 0.8;
    };

    cursor = {
      package = pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Dracula-Purple";
      size = 24;
    };

    fonts = {

      serif = {
        package = pkgs.libertinus;
        name = "Libertinus Serif";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter Variable";
      };

      monospace = {
        package = pkgs.anonymous-pro-fonts;
        name = "Anonymous Pro";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 28;
        desktop = 12;
        popups = 12;
      };

      # doesn't work for some reason
      # monospace = {
      #   package = pkgs.monaspace;
      #   # name = "Monaspace Krypton";
      #   # name = "Monaspace Argon";
      #   name = "Noto Sans";
      # };
      # serif = config.stylix.fonts.monospace;
      # sansSerif = config.stylix.fonts.monospace;
      # emoji = config.stylix.fonts.monospace;

    };
  };
}
