{ lib, pkgs, ... }:

let
  fuzzel-calc = pkgs.writeShellApplication {
    name = "fuzzel-calc";

    runtimeInputs = with pkgs; [
      fuzzel
      libqalculate
      wl-clipboard
      libnotify
    ];

    text = ''
      set -euo pipefail

      query="$(
        fuzzel \
          --dmenu \
          --prompt-only='calc> ' \
          --placeholder='5000 EUR to USD | 5 ft 11 in to cm | 150 to hex' \
          || true
      )"

      [[ -z "''${query//[[:space:]]/}" ]] && exit 0

      if [[ "$query" == ":rates" || "$query" == ":exrates" ]]; then
        if qalc -e 0 >/dev/null 2>&1; then
          notify-send "qalc" "Exchange rates updated"
          exit 0
        else
          notify-send "qalc" "Failed to update exchange rates"
          exit 1
        fi
      fi

      if result="$(qalc -t "$query" 2>&1)"; then
        printf '%s' "$result" | wl-copy
        notify-send "qalc: copied result" "$query = $result"
      else
        notify-send "qalc error" "$result"
        exit 1
      fi
    '';
  };
in
{
  home.packages = [
    fuzzel-calc
  ];

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = lib.mkAfter [
      "$mod, D, exec, fuzzel"
      "$mod, C, exec, fuzzel-calc"
    ];
  };
}
