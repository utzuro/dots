{
  config,
  lib,
  ...
}:
{
  # NOTE: currently unused. The LUKS mapping on these machines is `nixenc`
  # (see boot.nix), not `cryptroot` — keep the device in sync before enabling.
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    echo "Rollback running" > /mnt/rollback.log
     mkdir -p /mnt
     mount -t btrfs /dev/mapper/nixenc /mnt

     # Recursively delete all nested subvolumes inside /mnt/root
     btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
       echo "Deleting /$subvolume subvolume..." >> /mnt/rollback.log
       btrfs subvolume delete "/mnt/$subvolume"
     done

     echo "Deleting /root subvolume..." >> /mnt/rollback.log
     btrfs subvolume delete /mnt/root

     echo "Restoring blank /root subvolume..." >> /mnt/rollback.log
     btrfs subvolume snapshot /mnt/root-blank /mnt/root

     umount /mnt
  '';

  environment.persistence."/persist" = {
    # Never persist all of /etc on NixOS — it would shadow generated config.
    # Persist specific state directories instead.
    directories = [
      "/var/spool"
      "/root"
      "/srv"
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
    ];
    files = [
      # "/etc/machine-id"
      # Add more files you want to persist
    ];
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
}
