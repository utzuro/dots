{ inputs, config, pkgs, ... }:

{
  stylix = {

    enable = true;

    polarity = "dark";
    base16Scheme = ./theme.yaml;
    image = ./i/background.png;

    cursor = {
      package= pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Dracula-Purple";
    };

    fonts = {
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 20;
        popups = 12;
      };
      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Krypton";
        # name = "Monaspace Argon";
        # name = "Monaspace Argon";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;

    };
  };
}

