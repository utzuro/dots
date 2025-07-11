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

# Package arrays
cli_packages=(
  ack age asciidoctor atool avrdude awscli awsebcli bat bc bmap-tools buf
  cargo-edit cargo-watch ccls clang clang-tools cmake ctags curl dart delve
  diffutils duf eslint eza fd feh ffmpeg file findutils foremost fzf gdb
  ghostscript git glow go gofumpt golangci-lint gopls gotags gource graphviz
  gzip imagemagick inotify-tools jq killall kind kubectl kubectx ledger lfs
  libdvdcss2 libdvdread-dev libnotify-dev libqalculate llvm lnav lua lz4 lzip
  lzo lzop make mediainfo meson minicom minio-client mkvtoolnix moreutils mpc
  mpd mpv natscli ncdu ncmpcpp neovim ninja ninja-build nodejs nox nsxiv numbat
  p7zip pandoc patchelf pdftk peco pgcli php picocom pipe-viewer pistol
  poppler-utils postgresql progress protobuf python3-pip python3-setuptools
  python3-wheel qpdf ranger rar redis ripgrep ripgrep-all rsync rtorrent ruby
  rustup screen sdcv sqlc sqlite3 tango taskwarrior timewarrior tio tmux tuir
  typescript unar unzip usbutils uv vim vips w3m wget xc xz yarn yt-dlp zip
  zstd zsync
)

gui_packages=(
  drawio emacs libreoffice neovide obsidian qbittorrent vlc zathura
)

# Update
sudo apt update && sudo apt upgrade -y

read -rp "👾 Is this a fresh install? (y/N) 👀  " yn
if [[ "$yn" == "y" ]]; then
  echo "📦 Installing base development tools..."
  if [[ "$is_wsl" == false ]]; then
    sudo apt install -y build-essential linux-headers-$(uname -r) linux-firmware \
      lvm2 sudo intel-microcode grub-efi dosfstools mtools
  else
    sudo apt install -y build-essential sudo dosfstools mtools
  fi

  sudo apt install -y coreutils ntp cmake dhcpcd5 wpasupplicant iw iwd
fi

# Install CLI packages
echo
echo "🔧 Installing CLI tools..."
sudo apt install -y "${cli_packages[@]}"

# GUI packages (only outside WSL)
if [[ "$is_wsl" == false ]]; then
  read -rp "🎨 Do you want to install GUI and desktop tools? (y/N) 👀  " gui
  if [[ "$gui" == "y" ]]; then
    echo "🖼 Installing GUI packages..."
    sudo apt install -y "${gui_packages[@]}"

    # Add Chromium flags if installed
    if command -v chromium-browser &>/dev/null; then
      echo 'CHROMIUM_FLAGS="--ozone-platform-hint=auto"' | sudo tee /etc/chromium-browser/default
    fi

    read -rp "🎮 Is this a gaming PC? (y/N) 👀  " game
    if [[ "$game" == "y" ]]; then
      sudo apt install -y steam-installer wine winetricks gamescope \
        dosbox pcsx2 virtualbox virtualbox-ext-pack
    fi
  fi
fi

echo
echo "✅ All done. Happy hacking!"

