{ config, inputs, pkgs, user, ...}:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.consoleLogLevel = 0;
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# battery
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

# bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

#security
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "${user.name}" ];
    keepEnv = true;
    persist = true;
  }];
  environment.systemPackages = [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  programs.gpupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  let blocklist = builtins.readFile "github:StevenBlack/hosts/alternates/fakenes-gambling-porn-social/hosts";
  in
  {
    networking.extraHosts = ''
      "${blocklist}"
      '';
  }
}
