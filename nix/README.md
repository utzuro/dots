# My Nix setup

This is my personal nix configs. 
I create a directory per machine.
To install the configuration, enter the corresponding directory and run...

## for the system configuration

```sh
sudo nixos-rebuild switch --flake .#system
```

## for the home-manager configuration

```sh
home-manager switch --flake .#void
```

use override option to use local home-manager source:
```sh
home-manager switch --flake .#void --override-input home-manager ~/alchemy/summons/nixos/home-manager 
```

## to update the flake.lock

```sh
nix flake update
```
