{ inputs, config, pkgs, ... }:

{
  stylix = {

    enable = true;

    polarity = "dark";
    base16Scheme = ./theme.yaml;
    image = ./i/background.png;

    opacity = {
      applications = 0.8;
      desktop = 0.8;
      popups = 0.8;
      terminal = 0.8;
    };

    cursor = {
      package= pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Dracula-Purple";
    };


    fonts = {

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 24;
        desktop = 12;
        popups = 12;
      };

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

