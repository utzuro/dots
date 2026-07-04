{ ... }:

{
  home.sessionPath = [ "$HOME/scripts" ];

  imports = [
    ./lib/mimelist.nix
  ];

  # NOTE: session variables are exported in attribute-name order (uppercase
  # sorts before lowercase), so UPPERCASE vars must not reference the
  # lowercase shortcuts below — use $HOME paths directly.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    alchemy = "$HOME/alchemy";
    a = "$HOME/alchemy";
    m = "$HOME/magic";
    magic = "$HOME/magic";
    manu = "$alchemy/manuscripts";
    manuscripts = "$alchemy/manuscripts";
    STARDICT_DATA_DIR = "$HOME/alchemy/manuscripts/ingredients/dicts/dic";
    LEDGER = "$HOME/alchemy/magic/manuscripts/ledger/main.ledger";
    MY_HOMEMANAGER = "$HOME/alchemy/summons/nixos/home-manager";
    ZATHURA_PLUGINS_PATH = "/usr/lib/zathura";

    WINEPREFIX = "$HOME/darkarts/lib/prefixes/wine";

    PI_OFFLINE = "1";

    # DEV
    # Go
    GOPATH = "$HOME/go";
    GOPRIVATE = "github.com/*";
    # Flutter
    CHROME_EXECUTABLE = "chromium";
    ANDROID_HOME = "$HOME/alchemy/ingredients/android";
    ANDROID_SDK_ROOT = "$HOME/alchemy/ingredients/android";
    # PATH = "$PATH:$HOME/alchemy/ingredients/flutter/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$HOME/.local/share/JetBrains/Toolbox/scripts";

    QT_FONT_DPI = "204";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    desktop = "$HOME";
    download = "$HOME/channeling";
    templates = "$HOME/magic";
    publicShare = "$HOME/magic";
    documents = "$HOME/magic";
    music = "$HOME/magic";
    pictures = "$HOME/magic";
    videos = "$HOME/magic";
  };

  home.file.".profile".text = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
  '';
}
