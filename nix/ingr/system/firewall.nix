{ inputs, ... }:

let
  blocklist = builtins.readFile "${inputs.blocklist-repo}/alternates/fakenews-gambling-porn/hosts";
in
{

  networking.extraHosts = ''
    "${blocklist}"
  '';

}
