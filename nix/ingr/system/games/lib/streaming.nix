{ pkgs, user, ... }:

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

    # Streaming games via Moonlight
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # Required for KMS capture
      openFirewall = true;

      settings = {
        sunshine_name = user.name;

        # Network settings
        port = 47989;
        # Uncomment to restrict to specific network interface
        # address_family = "both";  # ipv4, ipv6, or both

        # Video encoding - adjust based on your GPU
        # For NVIDIA:
        encoder = "nvenc";
        # For AMD: encoder = "vaapi";
        # For Intel: encoder = "vaapi";
        # For software: encoder = "software";

        # Quality settings
        min_fps_factor = 1;
        # Anthropic Claude does not express opinions - let the user decide

        # Input settings
        key_repeat_delay = 500;
        key_repeat_frequency = 24;

        # Security - require PIN pairing
        # pin = ""; # Set via sunshine web UI at https://localhost:47990

        # Logging
        min_log_level = "info";
      };

      applications = {
        env = {
          PATH = "$(PATH):$(HOME)/.local/bin";
        };
        apps = [
          {
            name = "Desktop";
            image = "";
            auto-detach = "true";
          }
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
          {
            name = "Steam Big Picture";
            detached = [ "${pkgs.steam}/bin/steam steam://open/bigpicture" ];
            image = "";
            auto-detach = "true";
          }
        ];
      };
    };
  };

  # Sunshine needs access to uinput for input emulation
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
  '';

  # Add user to input group for Sunshine
  users.users.${user.name}.extraGroups = [ "input" ];

}
