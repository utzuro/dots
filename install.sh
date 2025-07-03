#!/usr/bin/env bash

set -euo pipefail

### 🧠 Initialize
DIR="$(realpath "$(dirname "$0")")"
cd "$DIR" || exit

### 📦 Install Platform Packages
install_platform_packages() {
  printf "\n⌛... Installing missing packages... 📦☄\n"
  case "$OSTYPE" in
    linux-gnu*)
      read -rp "👾 Install Arch Linux packages? (y/N) 👀 " yn
      if [[ "${yn,,}" == "y" ]]; then
        "$DIR/packages/archinstall.sh"
      else
        echo "⏭️ Skipping Arch Linux packages."
      fi
      ;;
    darwin*)
      read -rp "🍏 Install Homebrew packages? (y/N) 👀 " yn
      if [[ "${yn,,}" == "y" ]]; then
        "$DIR/packages/mac.sh"
      else
        echo "⏭️ Skipping Homebrew packages."
      fi
      ;;
    linux-android*)
      echo "📱 Detected Android/Termux, installing..."
      "$DIR/packages/termux.sh"
      ;;
    cygwin*)
      echo "🪟 Detected Cygwin, installing..."
      "$DIR/packages/cygwin.sh"
      ;;
    msys*)
      echo "🪟 Detected MSYS/Windows, installing..."
      "$DIR/packages/win.sh"
      ;;
    *)
      echo "¯\\_(ツ)_/¯ Unknown system, packages won't be installed."
      ;;
  esac
}

### 🖼 Configure X11 and WM
setup_x11_and_wm() {
  if command -v xhost &>/dev/null; then
    printf "🧿 Detected Xorg, configuring...\n"
    ln -sfv "$DIR/config/xorg/.xinitrc" "$HOME/"

    mkdir -p "$HOME/.config"/{dunst,rofi,mpd,ncmpcpp,waybar,goread,ranger}

    ln -sfv "$DIR/config/dunst/"* "$HOME/.config/dunst/"
    ln -sfv "$DIR/config/goread/"* "$HOME/.config/goread/"
    ln -sfv "$DIR/config/ranger/"* "$HOME/.config/ranger/"
    ln -sfv "$DIR/config/mpd/"* "$HOME/.config/mpd/"
    ln -sfv "$DIR/config/waybar/"* "$HOME/.config/waybar/"
    # ln -sfv "$DIR/config/rofi/"* "$HOME/.config/rofi/"  # enable if needed

    cp -n "$DIR/config/xorg/.Xresources" "$HOME/"

    # Disable high DPI setting if no 4K display is detected
    if ! xrandr | grep -q '3840x'; then
      sed -i -e 's/^Xft.dpi: 192/!Xft.dpi: 192/' "$HOME/.Xresources"
    fi
  fi

  if [ -d "$HOME/.config/i3" ]; then
    printf "🧿 Detected i3, configuring...\n"
    ln -sfv "$DIR/config/i3/config" "$HOME/.config/i3/"
  fi

  if [ -d "$HOME/.config/hypr" ]; then
    printf "🧿 Detected Hyprland, configuring...\n"
    rm -rf "$HOME/.config/hypr"
    ln -sfv "$DIR/config/hypr" "$HOME/.config/"
  fi
}

### 🧪 Install OS-agnostic shell tools
install_shell_tools() {
  printf "\n⌛... Installing and configuring OS-agnostic pkgs... 📂\n"
  "$DIR/packages/shell_install.sh"
}

### 🚀 Run Script
main() {
  install_platform_packages
  setup_x11_and_wm
  install_shell_tools
}

main "$@"

