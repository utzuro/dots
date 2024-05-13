{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # unreal
    godot_4
    blender
  ];
}
