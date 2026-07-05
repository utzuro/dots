#!/usr/bin/env bash
set -e

echo
echo "⌛... Configuring Linux... 🖳"

# --- Set up user groups ---
echo
echo "⌛... Adding user to required groups... 👥"
if [ -z "${USER:-}" ]; then USER=$(whoami); fi

# Only join groups that exist on this distro; e.g. docker or vboxusers
# may be missing until the corresponding package is installed.
for grp in input docker plugdev vboxusers lp; do # lp is for Bluetooth
	if getent group "$grp" >/dev/null 2>&1; then
		sudo usermod -aG "$grp" "$USER"
	else
		echo "⏭️  Group '$grp' does not exist here, skipping"
	fi
done

echo "✅ Linux group configuration complete!"
