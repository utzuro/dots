{ pkgs, lib, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ]; 
    fcitx5.waylandFrontend = true;
  };
  home.file.".config/fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=mozc

    [Groups/0/Items/0]
    Name=keyboard-us
    Layout=

    [Groups/0/Items/1]
    Name=mozc
    Layout=

    [GroupOrder]
    0=Default
    '';
  home.file.".config/fcitx5/config".text = ''
    [Hotkey]
    EnumerateWithTriggerKeys=True
    AltTriggerKeys=
    EnumerateForwardKeys=
    EnumerateBackwardKeys=
    EnumerateSkipFirst=False
    EnumerateGroupForwardKeys=
    EnumerateGroupBackwardKeys=
    TogglePreedit=

    [Hotkey/TriggerKeys]
    0=Super+comma

    [Hotkey/ActivateKeys]
    0=F2

    [Hotkey/DeactivateKeys]
    0=F1

    [Hotkey/PrevPage]
    0=Up

    [Hotkey/NextPage]
    0=Down

    [Hotkey/PrevCandidate]
    0=Shift+Tab

    [Hotkey/NextCandidate]
    0=Tab

    [Behavior]
    ActiveByDefault=False
    resetStateWhenFocusIn=No
    ShareInputState=No
    PreeditEnabledByDefault=True
    ShowInputMethodInformation=False
    showInputMethodInformationWhenFocusIn=False
    CompactInputMethodInformation=False
    ShowFirstInputMethodInformation=False
    DefaultPageSize=5
    OverrideXkbOption=False
    CustomXkbOption=
    EnabledAddons=
    DisabledAddons=
    PreloadInputMethod=True
    AllowInputMethodForPassword=False
    ShowPreeditForPassword=False
    AutoSavePeriod=30
  '';
}
