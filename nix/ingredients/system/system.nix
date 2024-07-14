{ config, pkgs, user, system, ...}:

{
  hardware.enableAllFirmware = true;
  environment.pathsToLink = [ "/libexec" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 0;
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${system.musdir}"; 
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "MPD"
      }
    '';
    user = "${user.name}";
  };
  systemd.services.mpd.environment = {
    "XDG_RUNTIME_DIR" = "/run/user/1000";
  };

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    zsh vim tmux git wget ranger
    ack peco progress jq
    playerctl pavucontrol
    ntfs3g
  ];
}
