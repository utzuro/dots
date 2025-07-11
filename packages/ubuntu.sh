#!/usr/bin/env bash
set -e

echo
echo "⌛... Installing all the packages for Ubuntu... 🖳"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# Detect WSL
is_wsl=false
if grep -qiE "(microsoft|wsl)" /proc/version; then
  echo "🧠 Detected WSL environment"
  is_wsl=true
fi

# Valid APT packages only
cli_packages=(
  vim git tmux ranger rsync wget curl file
  neovim ack ripgrep fzf fd-find duf peco progress jq moreutils bat
  unzip zip gzip xz-utils atool zstd lz4 lzip rar unar p7zip-full
  ncdu usbutils htop iotop bc ledger taskwarrior timewarrior inotify-tools
  cmake llvm clang clang-tools build-essential make gdb universal-ctags
  python3-pip python3-setuptools python3-wheel
  golang-go nodejs npm ruby
  sqlite3 postgresql redis
  screen minicom picocom tio
  meson libnotify-bin graphviz imagemagick ffmpeg mkvtoolnix pdftk poppler-utils foremost
  mpd mpc ncmpcpp mpv yt-dlp rtorrent mediainfo
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

# Fallbacks: Snap-based tools
snap_fallbacks=(
  glow golangci-lint kubectl protobuf sqlc tango
)
for pkg in "${snap_fallbacks[@]}"; do
  if ! command -v "$pkg" &>/dev/null; then
    echo "⚠️ Installing $pkg via snap..."
    sudo snap install "$pkg" --classic || true
  fi
done

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

echo
echo "✅ Ubuntu package installation complete!"

