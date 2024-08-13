{ inputs, config, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./i/background.png;
    polarity = "dark";
    base16Scheme = ./theme.yaml;
    fonts = {
      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Krypton";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
  };
}

