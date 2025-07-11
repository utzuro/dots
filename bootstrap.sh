#!/usr/bin/env bash
set -e

echo
echo "🧰 Running platform bootstrap installer..."

DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
PKG_DIR="$DIR/packages"

# Detect WSL
is_wsl=false
if grep -qiE "(microsoft|wsl)" /proc/version; then
  echo "🧠 Detected WSL environment"
  is_wsl=true
fi

# Detect OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  distro_id="${ID,,}"
else
  echo "❌ Could not detect your OS. Aborting."
  exit 1
fi

echo "📦 Detected distribution: $distro_id"

# --- 1. Run platform-specific install script ---
case "$distro_id" in
  arch)
    echo "🚀 Starting Arch Linux setup..."
    bash "$PKG_DIR/install-arch.sh"
    ;;
  ubuntu|debian)
    echo "🚀 Starting Ubuntu/Debian setup..."
    bash "$PKG_DIR/install-ubuntu.sh"
    ;;
  *)
    echo "❌ Unsupported distro: $distro_id"
    exit 1
    ;;
esac

# --- 2. Run dotfile/shell/config installer ---
if [[ -f "$PKG_DIR/shell_install.sh" ]]; then
  echo
  echo "🪄 Running shell config installer..."
  bash "$PKG_DIR/shell_install.sh"
else
  echo "⚠️  No shell_install.sh found in $PKG_DIR. Skipping."
fi

echo
echo "✅ Bootstrap complete!"

