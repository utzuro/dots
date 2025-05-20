#!/usr/bin/env bash

set -euo pipefail

# Allow current home-manage configurationt to buld
export ALLOW_UNFREE=1
export ALLOW_UNSAFE=1

# Get first argument as a pc name
if [ $# -ne 1 ]; then
    echo "Usage: $0 <pc-name>"
    exit 1
fi

PC=${1}

# Buld the new system-wide configuration
nixos-rebuild switch --flake .#$PC --impure --use-remote-sudo
