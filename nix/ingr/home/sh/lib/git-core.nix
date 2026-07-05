# Portable Git identity and defaults, safe for every host including
# nix-on-droid. Signing, hooks, maintenance timers and extra tooling
# stay in git.nix (desktop).

{ user, ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      # base configs
      user.name = user.public_name;
      user.email = user.email;

      alias = {
        co = "checkout";
        sw = "switch";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      url = {
        "git@github.com:" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        "git@github.com:cyber-space/" = {
          insteadOf = [
            "https://github.com/cyber-space/"
          ];
        };
      };
    };

    ignores = [
      "*~"
      "*.swp"

      ".claude/"
      ".context/"
      "todo"
      "PLAN.md"
      ".env"
    ];
  };
}
