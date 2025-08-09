{...}:

{
  home.sessionPath = [ "$HOME/scripts" ];

  imports = [
    ./lib/mimelist.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    alchemy = "$HOME/alchemy";
    a = "$HOME/alchemy";
    m = "$HOME/magic";
    magic = "$HOME/magic";
    manu = "$alchemy/manuscripts";
    manuscripts = "$alchemy/manuscripts";
    STARDICT_DATA_DIR = "$manuscripts/ingredients/dicts/dic";
    LEDGER = "$HOME/alchemy/manuscripts/ledger/main.ledger";
    ZATHURA_PLUGINS_PATH = "/usr/lib/zathura";

    # DEV
    # Go
    GOPATH = "$HOME/go";
    GOPRIVATE="github.com/*";
    # Flutter
    CHROME_EXECUTABLE="chromium";
    ANDROID_HOME="$HOME/Android/Sdk";
    ANDROID_SDK_ROOT="$HOME/Android/Sdk";
    PATH="$HOME/alchemy/ingredients/flutter/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PATH";
    # IDE
    PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts";

    NIXPKGS_ALLOW_INSECURE = "1";
    NIXPKGS_ALLOW_UNFREE = "1";

    QT_FONT_DPI = "204";

  };

  home.file.".profile".text = ''
  export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    '';
}
