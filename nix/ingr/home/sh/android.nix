{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # android
    flutter
    # androidenv.test-suite
    androidenv.androidPkgs.tools
    androidenv.androidPkgs.platform-tools
    androidenv.androidPkgs.ndk-bundle
    androidenv.androidPkgs.emulator
    androidenv.androidPkgs.androidsdk
  ];
}
