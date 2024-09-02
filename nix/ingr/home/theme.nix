{ inputs, config, pkgs, ... }:

{
  stylix = {

    enable = true;

    polarity = "dark";
    base16Scheme = ./theme.yaml;
    image = ./i/background.png;

    opacity = {
      applications = 0.8;
      desktop = 0.7;
      popups = 0.7;
      terminal = 0.7;
    };

    cursor = {
      package= pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Dracula-Purple";
    };

    fonts = {
      sizes = {
        applications = 12;
        terminal = 26;
        desktop = 20;
        popups = 20;
      };
      monospace = {
        package = pkgs.monaspace;
        # name = "Monaspace Krypton";
        name = "Monaspace Argon";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
  };
}

