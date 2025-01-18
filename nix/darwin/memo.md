# Memos

## Channel problem
If there are warning like "warning: Nix search path entry '/nix/var/nix/profiles/per-user/root/channels' does not exist, ignoring" when running nix-shell, you can fix it by running the following commands:

```sh
sudo -i nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo -i nix-channel --update nixpkgs
```
