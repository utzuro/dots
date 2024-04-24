{ inputs, pkgs, user, ... }:

let 
  blocklist = builtins.readFile "${inputs.blocklist-repo}/alternates/fakenews-gambling-porn-social/hosts";
in
{
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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

  networking.extraHosts = ''
    "${blocklist}"
    '';
}
