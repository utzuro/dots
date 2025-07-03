#!/usr/bin/env bash

set -euo pipefail

alchemy="$HOME/alchemy"
magic="$HOME/magic"
DIR="$(realpath "$(dirname "$0")/..")"

### 🗂 Directory Setup ###
create_directories() {
  printf "\n⌛... Creating default folders... 📂\n"
  mkdir -p "$HOME"/{channeling,mnt,aws}
  mkdir -p "${alchemy:?}"/{ingredients,summons}
  mkdir -p "${magic:?}/ingredients"
}

### 📝 File Setup ###
create_default_files() {
  printf "\n⌛... Creating default files... 📝\n"
  touch "$HOME"/.zprofile "$HOME"/.secrets "$HOME"/.awsrc
}

### 🧙 Clone Scripts Repo ###
setup_scripts_repo() {
  printf "\n⌛... Summoning scripts... 🧙\n"
  if [ ! -d "$alchemy/scripts" ]; then
    git clone https://gitlab.com/utzuro/scripts.git "$alchemy/scripts"
    (
      cd "$alchemy/scripts" || exit
      git remote remove origin
      git remote add origin git@gitlab.com:utzuro/scripts.git
    )
  else
    printf "✅ Scripts repo already exists. Skipping clone.\n"
  fi
}

### 🔗 Link Dotfiles ###
link_dotfiles() {
  printf "\n⌛... Linking configuration files to the corresponding places in the system... 🖇\n"

  printf "\n⌛... Linking vim configs... 📝\n"
  ln -sfv "$DIR/config/vim/.vimrc" "$HOME"/
  mkdir -p "$HOME/.config/nvim"
  ln -sfv "$DIR/config/vim/nvim/init.vim" "$HOME/.config/nvim/init.vim"

  ln -sfv "$DIR/config/vim/.ideavimrc" "$HOME"/
  mkdir -p "$HOME/.vim"
  for file in "$DIR"/config/vim/.vim/*.vim; do
    ln -sfv "$file" "$HOME/.vim/"
  done

  # Fix spellcheck
  mkdir -p "$HOME/.vim/after/syntax"
  ln -sfv "$DIR/config/vim/.vim/after/syntax/asciidoc.vim" "$HOME/.vim/after/syntax/"

  printf "📝 Installing vim plugins... 🚀\n"
  vim +PlugInstall +qall || true
  nvim +PlugInstall +qall || true
}

### 🛠 Shell & Tool Setup (if not using Home Manager) ###
manual_shell_and_tools() {
  if [ ! -x "$HOME/.nix-profile/bin/home-manager" ]; then
    printf "\n⌛... Nix not detected — installing shell tools manually... 🛠\n"

    printf "\n⌛... Linking shell configs... 🖥\n"

    mkdir -p "$HOME/.config"/{mpd}
    ln -sfv "$DIR/config/mpd/"* "$HOME/.config/mpd/"

    ln -sfv "$DIR/config/zsh/.zshrc" "$HOME"/
    ln -sfv "$DIR/config/zsh/.p10k.zsh" "$HOME"/
    ln -sfv "$DIR/config/.bashrc" "$HOME"/
    ln -sfv "$DIR/config/tmux/.tmux.conf" "$HOME"/

    printf "\n⌛... Getting ready files that shouldn't be linked... 🌐\n"
    touch "$HOME"/.profile 

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
      printf "📝 Oh My Zsh already installed.\n"
    fi

    if [ ! -d "$HOME/.zplug" ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
      printf "📝 Run 'zplug install' to install plugins.\n"
    else
      printf "📝 Zplug already installed.\n"
    fi

    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
      git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
      printf "📝 Install tmux plugins with Ctrl+B I\n"
    else
      printf "📝 TPM already installed.\n"
    fi

    printf "\n⌛... Linking terminal tools configs... 🖥\n"
    mkdir -p "$HOME/.config/ncmpcpp"
    ln -sfv "$DIR/config/ncmpcpp/"* "$HOME/.config/ncmpcpp/"

    mkdir -p "$HOME/.config/ranger"
    if [ ! -d "$HOME/.config/ranger/plugins/ranger_devicons" ]; then
      git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"
    fi

    ln -sfv "$DIR/config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
    ln -sfv "$DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

    printf "\n⌛... Installing and configuring OS-agnostic packages... 📦\n"
    "$DIR/packages/osagnostic.sh"
  fi
}

### 🔐 SSH Config ###
setup_ssh() {
  printf "\n⌛... Linking SSH config... 🔑\n"
  mkdir -p "$HOME/.ssh"
  cp -n "$DIR/config/ssh/config" "$HOME/.ssh/config"

  if [ ! -f "$HOME/.ssh/utzuro" ]; then
    ssh-keygen -f "$HOME/.ssh/utzuro" -N ''
  fi
}

### 🖼 Misc files ###
link_images() {
  printf "\n⌛... Linking image files... 🖇\n"
  ln -sfv "$DIR/ingr/i/.face" "$HOME/"
  ln -sfv "$DIR/ingr/i/background.png" "$HOME/"
}

### 📦 Flatpak ###
install_flatpak() {
  printf "\n⌛... Installing Flatpak... 📦\n"
  if command -v flatpak >/dev/null; then
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak update || true
  else
    printf "⚠️  Flatpak is not installed. Skipping.\n"
  fi
}

### 🚀 Run All ###
main() {
  create_directories
  create_default_files
  setup_scripts_repo
  link_dotfiles
  manual_shell_and_tools
  link_images
  setup_ssh
  install_flatpak
  printf "\n🔥 Shell tools installation complete! 🔥\n"
}

main "$@"

