{ pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ]; 
      waylandFrontend = true;
      # plasma6Support = true; // default if plasma6.enable
      ignoreUserConfig = true;
      settings.inputMethod = { 
        "Groups/0" = {
          "Name" = "Default";
          "Default Layout" = "us";
          "DefaultIM" = "mozc";
        };
        "Groups/0/Items/0" = {
          "Name" = "keyboard-us";
          "Layout" = null;
        };
        "Groups/0/Items/1" = {
          "Name" = "mozc";
          "Layout" = null;
        };
        "GroupOrder" = {
          "0" = "Default";
        };
      };
      quickPhrase = { 
        smile = "（・∀・）"; 
        angry = "(￣ー￣)";
      };
    };
  };
  # home.file.".config/fcitx5/config".text = ''
  #   [Hotkey]
  #   TriggerKeys=
  #   EnumerateWithTriggerKeys=True
  #   AltTriggerKeys=
  #   EnumerateForwardKeys=
  #   EnumerateBackwardKeys=
  #   EnumerateSkipFirst=False
  #   EnumerateGroupForwardKeys=
  #   EnumerateGroupBackwardKeys=
  #   ActivateKeys=
  #   DeactivateKeys=
  #   TogglePreedit=

  #   [Hotkey/PrevPage]
  #   0=Up

  #   [Hotkey/NextPage]
  #   0=Down

  #   [Hotkey/PrevCandidate]
  #   0=Shift+Tab

  #   [Hotkey/NextCandidate]
  #   0=Tab

  #   [Behavior]
  #   ActiveByDefault=False
  #   resetStateWhenFocusIn=No
  #   ShareInputState=No
  #   PreeditEnabledByDefault=True
  #   ShowInputMethodInformation=False
  #   showInputMethodInformationWhenFocusIn=False
  #   CompactInputMethodInformation=False
  #   ShowFirstInputMethodInformation=False
  #   DefaultPageSize=5
  #   OverrideXkbOption=False
  #   CustomXkbOption=
  #   EnabledAddons=
  #   DisabledAddons=
  #   PreloadInputMethod=True
  #   AllowInputMethodForPassword=False
  #   ShowPreeditForPassword=False
  #   AutoSavePeriod=30
  # '';
}
