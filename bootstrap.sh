#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo
echo "🧰 Running platform bootstrap installer..."

# Resolve repo root + packages dir (works in bash + msys2 bash)
DIR="$(
	cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 || exit
	pwd -P
)"
PKG_DIR="$DIR/packages"

# --- Detect environment toggles ---
is_wsl=false
# WSL kernels include 'microsoft' in /proc/version; MSYS2 does not.
if [[ -r /proc/version ]] && grep -qiE "(microsoft|wsl)" /proc/version; then
	echo "🧠 Detected WSL environment"
	is_wsl=true
fi

# --- Detect distro / platform ---
distro_id=""
pretty_src=""

# Termux (Android)
if [[ -n "${PREFIX:-}" && -d /data/data/com.termux ]]; then
	distro_id="termux"
	pretty_src="termux env"
fi

# macOS (no /etc/os-release)
uname_s="$(uname -s 2>/dev/null || echo "")"
if [[ -z "$distro_id" && "$uname_s" == "Darwin" ]]; then
	distro_id="macos"
	pretty_src="uname -s:$uname_s"
fi

# Prefer /etc/os-release when present (Linuxes incl. WSL)
if [[ -z "$distro_id" && -f /etc/os-release ]]; then
	# shellcheck disable=SC1091
	. /etc/os-release
	# Some environments (MSYS2) may set ID=msys – normalize to msys2
	case "${ID,,}" in
	msys | msys2) distro_id="msys2" ;;
	*) distro_id="${ID,,}" ;;
	esac
	pretty_src="/etc/os-release"
fi
# Fallbacks for MSYS2 / Cygwin / MinGW where os-release may vary
if [[ -z "$distro_id" ]]; then
	case "$uname_s" in
	MSYS_NT* | MINGW* | CYGWIN*)
		distro_id="msys2"
		pretty_src="uname -s:$uname_s"
		;;
	esac
fi

# Extra guard: if pacman exists and /etc/msystem exists, likely MSYS2
if [[ -z "$distro_id" && -x /usr/bin/pacman && -f /etc/msystem ]]; then
	distro_id="msys2"
	pretty_src="/etc/msystem"
fi

# Git Bash can look like MSYS2, but has no pacman.
if [[ "$distro_id" == "msys2" ]] && ! command -v pacman >/dev/null 2>&1; then
	echo "🧠 Detected Git Bash environment (MSYS2 without pacman)"
	distro_id="gitbash"
	pretty_src="${pretty_src:+$pretty_src, }no pacman"
fi

if [[ -z "$distro_id" ]]; then
	echo "❌ Could not detect your OS. Aborting."
	exit 1
fi

echo "📦 Detected distribution: $distro_id (${pretty_src:-unknown source})"

# --- 1. Run platform-specific install script ---
case "$distro_id" in
nixos)
	echo "🚀 Detected NixOS, no need to install packages"
	;;
macos)
	echo "🚀 Starting macOS setup..."
	bash "$PKG_DIR/mac.sh"
	;;
arch)
	echo "🚀 Starting Arch Linux setup..."
	bash "$PKG_DIR/archlinux.sh"
	;;
ubuntu | debian)
	echo "🚀 Starting Ubuntu/Debian setup..."
	bash "$PKG_DIR/ubuntu.sh"
	;;
amzn | amzn2 | amazon)
	echo "🚀 Starting Amazon Linux setup..."
	bash "$PKG_DIR/awslinux.sh"
	;;
msys2)
	# On native Windows MSYS2, you're not in WSL, so treat as MSYS2 even if $is_wsl=true due to edge cases.
	echo "🚀 Starting MSYS2 setup..."
	bash "$PKG_DIR/msys2.sh"
	;;
gitbash)
	echo "🚀 Starting Git Bash setup..."
	bash "$PKG_DIR/win.sh"
	;;
termux)
	echo "🚀 Starting Termux setup..."
	bash "$PKG_DIR/termux.sh"
	;;
*)
	echo "❌ Unsupported distro: $distro_id"
	exit 1
	;;
esac

# --- 2. Run dotfile/shell/config installer ---
echo "🪄 Running shell config installer..."
bash "$PKG_DIR/shell.sh"

echo
echo "✅ Bootstrap complete!"
