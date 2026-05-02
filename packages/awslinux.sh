#!/usr/bin/env bash
set -e

echo
echo "⌛... Configuring EC2 workspace... 🖳"
DIR="$(
	cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit
	pwd -P
)"

# --- Shared shell setup ---
"$DIR/shell.sh"

# --- Extra EC2 packages ---
sudo yum install -y ranger
sudo yum install -y gcc kernel-devel make ncurses-devel

echo "✅ EC2 workspace setup complete!"
