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
  ShareInputState=No
  PreeditEnabledByDefault=False
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
