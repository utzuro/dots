{ inputs, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    (python311.withPackages (p: [
      p.pywayland
    ]))
  ];

  programs.ags = {
    enable = true;
    configDir = ./.config/ags;

    extraPackages = with pkgs; [
    ];
  };
}
