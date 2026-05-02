#!/usr/bin/env bash
set -e

echo
echo "⌛... Installing all the packages for Arch Linux... 🖳"
DIR="$(
	cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit
	pwd -P
)"

# --- Detect WSL ---
is_wsl=false
if grep -qiE "(microsoft|wsl)" /proc/version; then
	echo "🧠 Detected WSL environment"
	is_wsl=true
fi

is_yes() {
	case "${1:-}" in
	[yY] | [yY][eE][sS]) return 0 ;;
	*) return 1 ;;
	esac
}

# --- Package lists ---
cli_packages=(
	ack age asciidoctor atool avrdude aws-cli-v2 awsebcli bat bc bmap-tools buf
	cargo-edit cargo-watch ccls clang clang-tools-extra cmake ctags curl dart delve
	diffutils duf eslint eza fd feh ffmpeg file findutils foremost fzf gdb
	ghostscript git glow go gofumpt golangci-lint gopls gotags gource graphviz
	gzip imagemagick inotify-tools jq killall kind kubectl kubectx ledger-git lfs
	libdvdcss libdvdread libnotify libqalculate llvm lnav lua lz4 lzip lzo lzop make
	mediainfo meson minicom minio-client mkvtoolnix-cli moreutils mpc mpd mpv
	natscli ncdu ncmpcpp neovim ninja nodejs nox nsxiv numbat p7zip pandoc patchelf
	pdftk peco pgcli php picocom pipe-viewer pistol poppler postgresql redis ripgrep
	ripgrep-all rsync rtorrent ruby rustup screen sdcv sqlc sqlite tango
	taskwarrior timewarrior tio tmux tuir typescript unar unzip usbutils uv vim vips
	w3m wget xc xz yarn yt-dlp zip zstd zsync
)

gui_packages=(
	drawio emacs libreoffice-fresh neovide obsidian qbittorrent vlc zathura
)

# --- Update system ---
sudo pacman -Syu --noconfirm --sudoloop

read -rp "👾 Is this a fresh Arch install? (y/N) 👀 " yn
if is_yes "$yn"; then
	echo "📦 Installing system essentials..."
	sudo pacman -S base-devel linux linux-headers linux-firmware lvm2 sudo intel-ucode --noconfirm
	sudo pacman -S coreutils ntp grub efibootmgr dosfstools mtools cmake dhcpcd wpa_supplicant iw iwd --noconfirm

	# Install yay if missing.
	if ! command -v yay &>/dev/null; then
		echo "⌛... Installing yay..."
		tempdir="temp_yay_install_folder"
		git clone https://aur.archlinux.org/yay.git "$DIR/$tempdir"
		(cd "$DIR/$tempdir" && makepkg -si --noconfirm)
		rm -rf "$DIR/$tempdir"
	fi

	yay -Syu --noconfirm --sudoloop

	# Install paru.
	yay -S paru --noconfirm --sudoloop

	# Battery manager.
	if [[ $(upower --enumerate 2>/dev/null | grep battery) ]]; then
		sudo pacman -S acpi tlp --noconfirm
		sudo systemctl enable --now tlp
	fi

	# Bluetooth.
	sudo pacman -S bluez bluez-utils bluez-plugins --noconfirm
	sudo systemctl enable --now bluetooth
fi

# --- Install CLI packages ---
echo "🔧 Installing CLI tools..."
paru -S --noconfirm --sudoloop "${cli_packages[@]}"

# --- Optional GUI setup (non-WSL only) ---
if [[ "$is_wsl" == false ]]; then
	read -rp "🎨 Do you want to install GUI and desktop tools? (y/N) 👀 " gui
	if is_yes "$gui"; then
		echo "🖼 Installing GUI packages..."
		paru -S --noconfirm --sudoloop "${gui_packages[@]}"

		# Chromium ozone flags.
		if [ -f /etc/chromium-flags.conf ]; then
			echo '--ozone-platform-hint=auto' | sudo tee /etc/chromium-flags.conf
		fi

		read -rp "🎮 Is this a gaming PC? (y/N) 👀 " game
		if is_yes "$game"; then
			paru -S --noconfirm gamescope steam wine-staging winetricks dosbox pcsx2 rpcs3-git virtualbox
		fi
	fi
fi

echo
echo "🔥 Arch Linux installation complete! 🔥"
