{ pkgs, ...}:

{
  imports = [
    ./wayland.nix
  ];

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures.gtk = true;
  };

  # monitor hot swapping
  # exec sleep 5; systemctl --user start kanshi.service 
  systemd.void.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };


}
