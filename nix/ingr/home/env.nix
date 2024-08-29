{...}:

{
  home.sessionPath = [ "$HOME/scripts" ];

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
    GOPATH = "$HOME/go";
    CHROME_EXECUTABLE="chrome";

    NIXPKGS_ALLOW_INSECURE = "1";
    NIXPKGS_ALLOW_UNFREE = "1";

    # ja input (not needed with patch)
    # QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };
}
