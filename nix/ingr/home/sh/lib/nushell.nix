{
  lib,
  pkgs,
  user,
  ...
}:

let
  starshipConfig = ../../../../../config/starship.toml;

  aliases = import ./aliases.nix { inherit user; };

  simpleAliases = aliases.core // {
    nsh = "nix develop --command nu";
    snsh = "nix develop --impure --command secretspec run --profile development -- nu";
  };
in
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    shellAliases = simpleAliases;

    settings = {
      show_banner = false;
      buffer_editor = "nvim";
      edit_mode = "vi";
      error_style = "fancy";
      highlight_resolved_externals = true;
      render_right_prompt_on_last_line = false;
      footer_mode = "auto";

      cursor_shape = {
        emacs = "inherit";
        vi_insert = "line";
        vi_normal = "block";
      };

      table = {
        mode = "rounded";
        index_mode = "auto";
      };

      history = {
        max_size = 100000;
        sync_on_enter = true;
        file_format = "sqlite";
        isolation = false;
      };

      completions = {
        algorithm = "fuzzy";
        case_sensitive = false;
        quick = true;
        partial = true;
        use_ls_colors = true;
      };

      ls.use_ls_colors = true;
      rm.always_trash = false;

      shell_integration = {
        osc2 = true;
        osc7 = true;
        osc8 = true;
        osc9_9 = false;
        osc133 = false;
        osc633 = false;
        reset_application_mode = false;
      };
    };

    extraEnv = ''
      let home = $nu.home-dir
      let is_windows = ($nu.os-info.name == "windows")

      $env.EDITOR = "nvim"
      $env.VISUAL = "nvim"

      if not $is_windows {
          $env.XDG_CONFIG_HOME = ($home | path join ".config")
      }

      $env.alchemy = ($home | path join "alchemy")
      $env.a = $env.alchemy
      $env.magic = ($home | path join "magic")
      $env.m = $env.magic
      $env.manuscripts = ($env.alchemy | path join "manuscripts")
      $env.manu = $env.manuscripts

      $env.STARDICT_DATA_DIR = ($env.manuscripts | path join "ingredients" "dicts" "dic")
      $env.LEDGER = ($env.alchemy | path join "magic" "manuscripts" "ledger" "main.ledger")
      $env.MY_HOMEMANAGER = ($home | path join "alchemy" "summons" "nixos" "home-manager")

      $env.GOPATH = ($home | path join "go")
      $env.GOPRIVATE = "github.com/*"
      $env.PNPM_HOME = ($home | path join ".local" "share" "pnpm")
      $env.WINEPREFIX = ($home | path join "darkarts" "lib" "prefixes" "wine")

      $env.PATH = ($env.PATH
          | prepend [
              ($home | path join "alchemy" "scripts")
              ($home | path join ".local" "bin")
              ($env.GOPATH | path join "bin")
              $env.PNPM_HOME
          ]
          | uniq)
    '';

    extraConfig = ''
      if (which starship | is-not-empty) {
          $env.STARSHIP_SHELL = "nu"

          def create_left_prompt [] {
              let duration = ($env.CMD_DURATION_MS? | default 0)
              let status = ($env.LAST_EXIT_CODE? | default 0)
              starship prompt --cmd-duration $duration $'--status=($status)'
          }

          $env.PROMPT_COMMAND = { || create_left_prompt }
          $env.PROMPT_COMMAND_RIGHT = ""
          $env.PROMPT_INDICATOR = ""
          $env.PROMPT_INDICATOR_VI_INSERT = ""
          $env.PROMPT_INDICATOR_VI_NORMAL = ""
          $env.PROMPT_MULTILINE_INDICATOR = "::: "

          $env.TRANSIENT_PROMPT_COMMAND = { || "" }
          $env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""
          $env.TRANSIENT_PROMPT_INDICATOR = ""
          $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
          $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
          $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""
      }

      def upd [] { git commit -am "minor update"; git push }
      def bump [] { git commit -am "version bump"; git push }
      def refactor [] { git commit -am "refactor"; git push }
      def hotfix [] { git commit -am "hotfix"; git push }
      def addtests [] { git commit -am "add tests"; git push }

      def build-my-home [] {
          ~/dots/nix/ingr/cleanup
          home-manager switch --flake ~/dots#${user.name}
      }

      def real [] { ledger -f $env.LEDGER bal Assets --real }
      def budgets [] { ledger -f $env.LEDGER bal Budget }
      def ron [] { redshift -P -O 3200 -b1 }
      def roff [] { redshift -P -O 6200 -b1 }
      def open-port [] {
          loop {
              date
              natpmpc -a 1 0 udp 60 -g 10.2.0.1
              natpmpc -a 1 0 tcp 60 -g 10.2.0.1
              sleep 45sec
          }
      }

      def tmain [] { tmux new-session -A -s main }
      def tls [] { tmux list-sessions }

      def --env yy [...args] {
          let tmp = (mktemp -t "yazi-cwd.XXXXXX")
          yazi ...$args --cwd-file $tmp
          let cwd = (open $tmp)
          rm -f $tmp

          if ($cwd != "" and $cwd != $env.PWD) {
              cd $cwd
          }
      }
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    enableZshIntegration = false;
    settings = builtins.fromTOML (builtins.readFile starshipConfig);
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableNushellIntegration = true;
    enableZshIntegration = false;
  };

  programs.direnv.enableNushellIntegration = lib.mkDefault true;
}
