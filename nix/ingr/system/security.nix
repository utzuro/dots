{ inputs, pkgs, ... }:

let 
  blocklist = builtins.readFile "${inputs.blocklist-repo}/alternates/fakenews-gambling-porn/hosts";
in
{
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.dbus.packages = [ pkgs.gcr ];
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "void" ];
    keepEnv = true;
    persist = true;
  }];
  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
    firejail
  ];

  networking.extraHosts = ''
    "${blocklist}"
    '';

  programs.firejail.wrappedBinaries = {
    steam = {
      executable = "${pkgs.steam}/bin/steam";
      profile = "${pkgs.firejail}/etc/firejail/steam.profile";
    };
    steam-run = {
      executable = "${pkgs.steam}/bin/steam-run";
      profile = "${pkgs.firejail}/etc/firejail/steam.profile";
    };
    # when I decide to try minecraft
    # prismlauncher = {
    #   executable = "${pkgs.prismlauncher}/bin/prismlauncher";
    #   profile = ./firejail-profiles/prismlauncher.profile;
    # };
  };
}
