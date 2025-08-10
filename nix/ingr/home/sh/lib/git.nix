{ config, pkgs, user, ... }:

{

  programs.git = {

    # base configs
    enable = true;
    lfs.enable = true;
    userName = "utzuro";
    userEmail = "utzuro@pm.me";

    signing = {
      signer = "utzuro";
      key = "utzuro@pm.me";
      signByDefault = true;
    };

    aliases = {
      co = "checkout";
      sw = "switch";
    };

    # extra configs
    hooks = {
      pre-commit = ./pre-commit-script.sh;
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      url = {
        "git@github.com:" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        "git@github.com:chikei-development/" = {
          insteadOf = [
            "https://github.com/chikei-development/"
          ];
        };
      };
    };

    ignores = [
      "*~"
      "*.swp"
    ];

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


    # diffs
    diff-highlight = {
      enable = false;
      pagerOpts = [
        "--tabs=4"
        "-RFX"
      ];
    };

    riff.enable = true;

    patdiff.enable = false;

    diff-so-fancy = {
      enable = false;
      markEmptyLines = true;
      pagerOpts = [
        "--tabs=4"
        "-RFX"
      ];
    };

    difftastic = {
      enable = false;
      enableAsDifftool = true;
      display = "side-by-side"; # "inline"
      background = "dark";
    };

    delta = {
      enable = false;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };

  };

  home.packages = with pkgs; [ 
    onefetch 
  ];

}
