{ pkgs
, buildFHSEnv
, writeShellScript
,
}:
let
  pico8Env = { name, runScript }:
    buildFHSEnv {
      inherit name runScript;
      targetPkgs = pkgs: (with pkgs; [
        xorg.libX11
        xorg.libXext
        xorg.libXcursor
        xorg.libXinerama
        xorg.libXi
        xorg.libXrandr
        xorg.libXScrnSaver
        xorg.libXxf86vm
        xorg.libxcb
        xorg.libXrender
        xorg.libXfixes
        xorg.libXau
        xorg.libXdmcp
        alsa-lib
        udev
        wget
      ]);
    };
in
pico8Env {
  name = "pico8";

  runScript = writeShellScript "pico8-wrapped" ''
    exec pico8 "$@"
  '';
}
