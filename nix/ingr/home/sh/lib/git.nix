{
  pkgs,
  user,
  inputs,
  ...
}:

{

  imports = [
    ./git-core.nix
  ];

  programs = {
    git = {
      # extra configs
      hooks = {
        pre-commit = ./pre-commit-script.sh;
      };

      signing = {
        format = "openpgp";
        key = user.email;
        signByDefault = true;
      };

      attributes = [
        "*.pdf diff=pdf"
      ];

      maintenance = {
        enable = true;
        timers = {
          daily = "Tue..Sun *-*-* 12:00:00";
        };
        repositories = [
        ];
      };

    };

    # diffs

    diff-so-fancy = {
      enable = false;
      settings = {
        markEmptyLines = true;
        pagerOpts = [
          "--tabs=4"
          "-RFX"
        ];
      };
    };

    riff.enable = false;

    patdiff.enable = false;

    diff-highlight = {
      enable = false;
      pagerOpts = [
        "--tabs=4"
        "-RFX"
      ];
    };

    difftastic = {
      enable = false;
      options = {
        enableAsDifftool = true;
        display = "side-by-side"; # "inline"
        background = "dark";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        "side-by-side" = true;
        "line-numbers" = true;
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
        "syntax-theme" = "Dracula";
        "keep-plus-minus-markers" = true;
        width = "variable";
      };
    };

    lazygit = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        lightTheme = false;
        activeBorderColor = [
          "violet"
          "bold"
        ];
        inactiveBorderColor = [ "black" ];
        selectedLineBgColor = [ "default" ];
        git = {
          pagers = [
            { pager = "delta --dark --paging=never"; }
            { pager = "diff-so-fancy"; }
          ];
        };
      };
    };

    # tools
    mergiraf = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
    };
  };

  home.packages = with pkgs; [
    onefetch
    jujutsu
    inputs.agents.packages.${pkgs.stdenv.hostPlatform.system}.tuicr
    mergiraf
    diffnav
  ];

}
