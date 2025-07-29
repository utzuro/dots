#!/usr/bin/env bash
set -e

echo
echo "⌛... Installing all the packages for Ubuntu... 🖳"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# Setup input
echo "⌨️ Setting up input sources..."
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']"

# Detect WSL
is_wsl=false
if grep -qiE "(microsoft|wsl)" /proc/version; then
  echo "🧠 Detected WSL environment"
  is_wsl=true
fi

# Valid APT packages only
cli_packages=(
  vim zsh git tmux ranger rsync wget curl file
  neovim ack ripgrep eza fzf fd-find duf peco progress jq moreutils bat
  unzip zip gzip xz-utils atool zstd lz4 lzip rar unar p7zip-full
  ncdu usbutils htop iotop bc ledger taskwarrior timewarrior inotify-tools
  cmake llvm clang clang-tools build-essential make gdb universal-ctags
  python3-pip python3-setuptools python3-wheel
  golang-go ruby
  sqlite3 postgresql redis
  screen minicom picocom tio
  meson libnotify-bin graphviz imagemagick ffmpeg mkvtoolnix pdftk poppler-utils foremost
  mpd mpc ncmpcpp mpv yt-dlp rtorrent mediainfo
  libfuse2
  cmatrix cowsay
  # input
  fcitx5 fcitx5-unikey fcitx5-configtool
)

gui_packages=(
  kitty
  emacs libreoffice qbittorrent vlc zathura
)

wm_packages=(
  i3 rofi 
  # sway swaybg swaylock grim slurp waybar wofi mako foot
  # hyprland hyprpaper hyprpicker hyprshot hyprctl
)

# Update system
sudo apt update && sudo apt upgrade -y

echo
echo "🔧 Installing CLI packages..."
sudo apt install -y "${cli_packages[@]}"

# Fix command name differences
echo "🔗 Creating compatibility symlinks (if needed)..."
[ -f /usr/bin/fdfind ] && sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd || true
[ -f /usr/bin/batcat ] && sudo ln -sf /usr/bin/batcat /usr/local/bin/bat || true

# Install docker
echo
echo "🐳 Installing Docker & Docker Compose..."

# Ensure keyrings directory exists
if [ ! -d /etc/apt/keyrings ]; then
    sudo install -m 0755 -d /etc/apt/keyrings
fi

# Add Docker's official GPG key if not present
if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Add Docker repository if not already present
DOCKER_REPO_FILE="/etc/apt/sources.list.d/docker.list"
if ! grep -q "download.docker.com/linux/ubuntu" "$DOCKER_REPO_FILE" 2>/dev/null; then
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee "$DOCKER_REPO_FILE" > /dev/null
fi

# Update package index
sudo apt-get update -qq

# Install Docker Engine & Compose plugin if not already installed
if ! dpkg -l | grep -q docker-ce; then
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# Enable Docker service if not already enabled
if ! systemctl is-enabled --quiet docker; then
    sudo systemctl enable docker
fi

# Start Docker if not running
if ! systemctl is-active --quiet docker; then
    sudo systemctl start docker
fi

# Add current user to Docker group if not already a member
if ! id -nG "$USER" | grep -qw docker; then
    sudo usermod -aG docker "$USER"
    echo "User added to docker group. Log out and back in for changes to take effect."
fi

echo "🐳 Docker & Docker Compose are installed and ready to use!"

# Fallbacks: Snap-based tools
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

# Get the flatpak ready
 echo "📦 Setting up Flatpak..."
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install anki
flatpak install vcmi
echo "📦 Flatpak is set up!"

# Go-based tools
echo "📦 Installing Go-based dev tools..."
export GOPATH="$HOME/go"
mkdir -p "$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"

go install github.com/kyleconroy/sqlc/cmd/sqlc@latest || true
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest || true
go install github.com/fatih/gomodifytags@latest || true
go install github.com/josharian/impl@latest || true
go install github.com/rogpeppe/godef@latest || true

# Setup services
mkdir -p ~/.config/systemd/user/
ln -sfv "$DIR/../config/systemd/user/fcitx5.service" ~/.config/systemd/user/
systemctl --user enable --now fcitx5.service


# GUI prompt (if not WSL)
if [[ "$is_wsl" == false ]]; then
  read -rp "🎨 Do you want to install GUI and desktop tools? (y/N) 👀  " gui
  if [[ "$gui" == "y" ]]; then
    echo "🖼 Installing GUI packages..."
    sudo apt install -y "${gui_packages[@]}"

    read -rp "🖥️ Do you want to install a window manager? (i3/sway/hyprland) (y/N) 👀 " wm
    if [[ "$wm" == "y" ]]; then
      echo "🪟 Installing window manager packages..."
      sudo apt install -y "${wm_packages[@]}"
    fi

    read -rp "🎮 Is this a gaming PC? (y/N) 👀 " game
    if [[ "$game" == "y" ]]; then
        sudo apt install software-properties-common apt-transport-https curl -y
        sudo dpkg --add-architecture i386
        sudo apt update
        flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE
    fi
  fi
fi

echo
echo "✅ Ubuntu package installation complete!"

