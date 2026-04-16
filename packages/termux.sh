#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

install_group() {
	local title="$1"
	shift
	local -a pkgs=("$@")
	if [[ ${#pkgs[@]} -eq 0 ]]; then
		return 0
	fi

	echo "?? Installing ${title}..."
	pkg install -y "${pkgs[@]}"
}

apply_termux_font() {
	local font_file=""

	if ! command -v fc-match >/dev/null 2>&1; then
		echo "??  fontconfig-utils is missing; skipping font application"
		return 0
	fi

	if command -v fc-cache >/dev/null 2>&1; then
		fc-cache -f >/dev/null 2>&1 || true
	fi

	for pattern in \
		'JetBrains Mono:style=Regular' \
		'JetBrains Mono' \
		'DejaVu Sans Mono:style=Book' \
		'DejaVu Sans Mono'; do
		font_file="$(fc-match -f '%{file}\n' "$pattern" 2>/dev/null | head -n1 || true)"
		if [[ -n "$font_file" && -f "$font_file" ]]; then
			break
		fi
	done

	if [[ -z "$font_file" || ! -f "$font_file" ]]; then
		echo "??  Could not locate an installed monospace TTF; skipping ~/.termux/font.ttf setup"
		return 0
	fi

	mkdir -p "$HOME/.termux"
	cp -f "$font_file" "$HOME/.termux/font.ttf"

	if command -v termux-reload-settings >/dev/null 2>&1; then
		termux-reload-settings || true
	fi

	echo "?? Applied terminal font from: $font_file"
}

echo
echo "?... Installing packages for Termux... ??"

echo "?? Updating package metadata..."
pkg update -y
pkg upgrade -y

core_packages=(
	coreutils findutils grep sed gawk diffutils file less which mandoc manpages
	tar gzip bzip2 xz-utils zip unzip p7zip zstd zsync lzip lz4 lzop ncurses-utils
)

shell_packages=(
	zsh tmux screen
)

editor_packages=(
	vim neovim emacs ctags
)

net_packages=(
	git git-lfs openssh curl wget rsync aria2 ca-certificates
	netcat-openbsd nmap kubectl awscli
)

android_packages=(
	termux-api termux-services
)

search_packages=(
	ripgrep ripgrep-all fd fzf tree ack-grep bat eza peco w3m
)

data_packages=(
	jq sqlite postgresql redis taskwarrior timewarrior
)

dev_packages=(
	build-essential clang llvm cmake ninja make pkg-config gdb patchelf
	python nodejs yarn golang rust perl ruby php lua54 dart
	ccls delve gopls uv
)

docs_packages=(
	asciidoctor pandoc glow graphviz poppler pdftk
)

media_packages=(
	ffmpeg imagemagick ghostscript mediainfo python-yt-dlp
	mpv mpd mpc ncmpcpp vlc rtorrent sdcv
)

system_packages=(
	htop duf ncdu lsof strace inotify-tools moreutils psmisc
	minicom picocom age atool buf qalc pv ledger
)

container_packages=(
	proot proot-distro
)

font_packages=(
	fontconfig fontconfig-utils ttf-jetbrains-mono ttf-dejavu ttf-nerd-fonts-symbols
)

install_group "core tools" "${core_packages[@]}"
install_group "shell and session tools" "${shell_packages[@]}"
install_group "editors" "${editor_packages[@]}"
install_group "network and VCS tools" "${net_packages[@]}"
install_group "Android integration tools" "${android_packages[@]}"
install_group "search and navigation tools" "${search_packages[@]}"
install_group "data and database tools" "${data_packages[@]}"
install_group "development toolchains" "${dev_packages[@]}"
install_group "documentation and diagram tools" "${docs_packages[@]}"
install_group "media tools" "${media_packages[@]}"
install_group "system, utility and serial tools" "${system_packages[@]}"
install_group "proot tools" "${container_packages[@]}"
install_group "fonts" "${font_packages[@]}"
apply_termux_font
