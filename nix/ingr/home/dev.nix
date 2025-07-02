{ pkgs, ...}:

{

  imports = [
    ./git.nix
  ];

  programs = {
    
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
      extensions = with pkgs; [
        gh-dash gh-f gh-s gh-i gh-poi gh-eco gh-cal gh-copilot gh2md
      ];
    }; # gh
  }; # programs

}
