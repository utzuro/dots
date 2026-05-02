#!/usr/bin/env bash
set -e

echo
echo "⌛... Installing all the packages for Ubuntu... 🖳"
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

# --- Core CLI packages ---
cli_packages=(
	vim zsh git tmux ranger rsync wget curl file mpv
	neovim ack ripgrep eza fzf fd-find duf peco progress jq moreutils bat
	unzip zip gzip xz-utils atool zstd lz4 lzip rar unar p7zip-full
	ncdu usbutils htop iotop bc ledger taskwarrior timewarrior inotify-tools

	# dev
	cmake llvm clang clang-tools build-essential make gdb universal-ctags
	python3-pip python3-setuptools python3-wheel
	golang-go
	ruby

	# db
	sqlite3 postgresql redis

	# libs
	screen minicom picocom tio
	meson graphviz imagemagick ffmpeg
	libfuse2 libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libzstd-dev
)

# --- Extra CLI packages ---
extra_cli_packages=(
	fonts-font-awesome

	# asobi
	cmatrix cowsay

	# media
	mpd mpc ncmpcpp yt-dlp rtorrent mediainfo
	pdftk poppler-utils foremost
)

gui_packages=(
	kitty
	emacs libreoffice qbittorrent vlc zathura
	inkscape blender librecad godot3

	# input
	fcitx5 fcitx5-unikey fcitx5-configtool

	# Furiganize
	# kakasi mecab mecab-naist-jdic-eucjp
)

wm_packages=(
	i3 rofi
	# sway swaybg swaylock grim slurp waybar wofi mako foot
	# hyprland hyprpaper hyprpicker hyprshot hyprctl

	# libs
	libnotify-bin
)

# --- Update system ---
sudo apt update && sudo apt upgrade -y
sudo apt autoremove

echo
echo "🔧 Installing CLI packages..."
sudo apt install -y "${cli_packages[@]}"
sudo apt install -y "${extra_cli_packages[@]}"

# --- Fix command name differences ---
echo "🔗 Creating compatibility symlinks..."
[ -f /usr/bin/fdfind ] && sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd || true
[ -f /usr/bin/batcat ] && sudo ln -sf /usr/bin/batcat /usr/local/bin/bat || true

# --- Install Docker ---
echo
echo "🐳 Installing Docker & Docker Compose..."

# Ensure keyrings directory exists.
if [ ! -d /etc/apt/keyrings ]; then
	sudo install -m 0755 -d /etc/apt/keyrings
fi

# Add Docker's official GPG key if not present.
if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Add Docker repository if not already present.
DOCKER_REPO_FILE="/etc/apt/sources.list.d/docker.list"
if ! grep -q "download.docker.com/linux/ubuntu" "$DOCKER_REPO_FILE" 2>/dev/null; then
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee "$DOCKER_REPO_FILE" >/dev/null
fi

# Update package index.
sudo apt-get update -qq

# Install Docker Engine and Compose plugin if not already installed.
if ! dpkg -l | grep -q docker-ce; then
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# Enable Docker service if not already enabled.
if ! systemctl is-enabled --quiet docker; then
	sudo systemctl enable docker
fi

# Start Docker if not running.
if ! systemctl is-active --quiet docker; then
	sudo systemctl start docker
fi

# Add current user to Docker group if not already a member.
if ! id -nG "$USER" | grep -qw docker; then
	sudo usermod -aG docker "$USER"
	echo "User added to docker group. Log out and back in for changes to take effect."
fi

echo "🐳 Docker & Docker Compose are installed and ready to use!"

# --- Install fonts ---
echo "🖋 Installing fonts..."
./packages/install-fonts.sh
fc-cache -fv

# --- Optional GUI setup (non-WSL only) ---
if [[ "$is_wsl" == false ]]; then
	read -rp "🎨 Do you want to install GUI and desktop tools? (y/N) 👀 " gui
	if is_yes "$gui"; then

		# Setup input.
		echo "⌨️ Setting up input sources..."
		gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']"

		echo "🖼 Installing GUI packages..."
		sudo apt install -y "${gui_packages[@]}"

		# Prepare Flatpak.
		echo "📦 Setting up Flatpak..."
		sudo apt install -y flatpak gnome-software-plugin-flatpak
		flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
		flatpak install -y flathub net.ankiweb.Anki
		flatpak install -y flathub com.jgraph.drawio.desktop
		echo "📦 Flatpak is set up!"

		read -rp "🖥️ Do you want to install window manager packages? (y/N) 👀 " wm
		if is_yes "$wm"; then
			echo "🪟 Installing window manager packages..."
			sudo apt install -y "${wm_packages[@]}"
		fi

		# Setup services.
		mkdir -p ~/.config/systemd/user/
		ln -sfv "$DIR/../config/systemd/user/fcitx5.service" ~/.config/systemd/user/
		systemctl --user enable --now fcitx5.service

		read -rp "🎮 Is this a gaming PC? (y/N) 👀 " game
		if is_yes "$game"; then
			sudo apt install software-properties-common apt-transport-https curl -y
			sudo dpkg --add-architecture i386
			sudo apt update
			flatpak install -y flathub com.valvesoftware.Steam.CompatibilityTool.Proton-GE
		fi

		# Fallbacks: snap-based tools.
		if command -v snap &>/dev/null; then
			snap_fallbacks=(
				glow golangci-lint kubectl protobuf sqlc tango
				slack discord chromium
			)
			for pkg in "${snap_fallbacks[@]}"; do
				if ! command -v "$pkg" &>/dev/null; then
					echo "⚠️ Installing $pkg via snap..."
					sudo snap install "$pkg" --classic || true
				fi
			done
		else
			echo "⚠️ Snap is not installed; skipping snap fallbacks."
		fi

	fi
fi

echo
echo "✅ Ubuntu package installation complete!"
