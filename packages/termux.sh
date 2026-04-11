#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo
echo "⌛... Installing packages for Termux... 📱"

pkg update -y
pkg upgrade -y

core_packages=(
	coreutils findutils grep sed gawk diffutils file less which man
	tar gzip xz bzip2 zip unzip p7zip ncurses-utils
)

shell_packages=(
	zsh tmux
)

editor_packages=(
	vim neovim
)

net_packages=(
	git openssh curl wget rsync ca-certificates
)

android_packages=(
	termux-api termux-services
)

search_packages=(
	ripgrep fd fzf tree
)

data_packages=(
	jq sqlite
)

dev_packages=(
	build-essential cmake pkg-config
	python nodejs golang rust perl ruby
)

system_packages=(
	htop ncdu lsof strace
)

net_extra_packages=(
	aria2 netcat-openbsd nmap tcpdump
)

container_packages=(
	proot proot-distro
)

media_packages=(
	ffmpeg imagemagick
)

misc_packages=(
	qalc bc
)

echo "📦 Installing core tools..."
pkg install -y "${core_packages[@]}"

echo "🐚 Installing shell tools..."
pkg install -y "${shell_packages[@]}"

echo "📝 Installing editors..."
pkg install -y "${editor_packages[@]}"

echo "🌐 Installing network and VCS tools..."
pkg install -y "${net_packages[@]}"

echo "🤖 Installing Android integration tools..."
pkg install -y "${android_packages[@]}"

echo "🔎 Installing search and navigation tools..."
pkg install -y "${search_packages[@]}"

echo "🧮 Installing data tools..."
pkg install -y "${data_packages[@]}"

echo "🛠 Installing dev toolchains..."
pkg install -y "${dev_packages[@]}"

echo "🧪 Installing system and debug tools..."
pkg install -y "${system_packages[@]}"

echo "📡 Installing extra network tools..."
pkg install -y "${net_extra_packages[@]}"

echo "📦 Installing proot tools..."
pkg install -y "${container_packages[@]}"

echo "🎛 Installing media tools..."
pkg install -y "${media_packages[@]}"

echo "🧰 Installing misc utilities..."
pkg install -y "${misc_packages[@]}"

echo
echo "✅ Termux package installation complete!"
