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

  services = {
    dbus.packages = [ pkgs.gcr ];
    clamav.daemon.enable = true;
    clamav.updater.enable = true;
    opensnitch.enable = true;
  };

  security = {
    polkit.enable = true;

    doas.enable = true;
    sudo.enable = false;
    doas.extraRules = [{
      users = [ "void" ];
      keepEnv = true;
      persist = true;
    }];

    # perf: allow any program to request real-time priority
    pam.loginLimits = [ { domain = "@users"; item = "rtprio"; type = "-"; value = 1; } ];
  };



  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
    firejail clamav
    opensnitch-ui
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
    prismlauncher = {
      executable = "${pkgs.prismlauncher}/bin/prismlauncher";
      profile = ./firejail-profiles/prismlauncher.profile;
    };
  };
}
