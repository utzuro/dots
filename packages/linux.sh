#!/usr/bin/env bash
set -e

echo
echo "⌛... Configuring Linux... 🖳"

# --- Set up user groups ---
echo
echo "⌛... Adding user to required groups... 👥"
if [ -z "${USER:-}" ]; then USER=$(whoami); fi
sudo usermod -aG input "$USER"
sudo usermod -aG docker "$USER"
sudo usermod -aG plugdev "$USER"
sudo usermod -aG vboxusers "$USER"
sudo usermod -aG lp "$USER" # Bluetooth

echo "✅ Linux group configuration complete!"
