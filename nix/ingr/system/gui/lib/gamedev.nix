{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # cli
    # godot_4
    # godot_4_cli
    # godot_4_editor
    # godot_4_export_templates

    # gui
    # godot_4_editor
    # unreal
  ];
}
