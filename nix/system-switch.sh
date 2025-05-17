#!/usr/bin/env bash

set -euo pipefail

# Allow current home-manage configurationt to buld
export ALLOW_UNFREE=1
export ALLOW_UNSAFE=1

# Buld the new system-wide configuration
ixos-rebuild switch --flake .#voidpc --impure --use-remote-sudo
