{ pkgs, ... }:

{

  services = {
    # TODO: Serving games ideas:
    # Homm
    # WoW / other mmo?
    # Arma / Squad
    # Minecraft / Factorio / Terraria
    # Quake, Doom, UT, Xonotic
    # OpenRA
    # 0 A.D. 
    # Mage (xmage)

    # Voice chat server

    # Streaming games
    sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        port = 47989;
        sunshine_name = "void";
      };
      applications = {
        # Example, change later
        env = {
          PATH = "$(PATH):$(HOME)/.local/bin";
        };
        apps = [
          {
            name = "1440p Desktop";
            prep-cmd = [
              {
                do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-4.mode.2560x1440@144";
                undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-4.mode.3440x1440@144";
              }
            ];
            exclude-global-prep-cmd = "false";
            auto-detach = "true";
          }
        ];
      };
    };
  };

}
