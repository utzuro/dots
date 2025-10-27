#!/usr/bin/env bash
set -euo pipefail

alchemy="$HOME/alchemy"
magic="$HOME/magic"
DIR="$(realpath "$(dirname "$0")/..")"

### ── Platform detection ─────────────────────────────────────────────────────
is_wsl=false
is_msys2=false

if [[ -r /proc/version ]] && grep -qiE "(microsoft|wsl)" /proc/version; then
  is_wsl=true
fi

if [[ -n "${MSYSTEM:-}" ]] || uname -o 2>/dev/null | grep -qi "msys"; then
  is_msys2=true
fi

have_cmd() { command -v "$1" >/dev/null 2>&1; }

# Safe sudo wrapper: no sudo on MSYS2, so just run the cmd (or warn)
sudo_safe() {
  if $is_msys2; then
    # MSYS2 doesn’t typically have sudo; most ops should be user-level
    "$@"
  else
    if have_cmd sudo; then sudo "$@"; else "$@"; fi
  fi
}

# Symlink helper: fallback to copy if symlink fails (Windows policy)
ln_sf_or_copy() {
  local src="$1" dst="$2"
  if ln -sfv "$src" "$dst" 2>/dev/null; then
    return 0
  fi
  # If symlink failed, try copy (preserving attrs where possible)
  printf "🔁 Symlink failed, copying instead: %s → %s\n" "$src" "$dst"
  mkdir -p "$(dirname "$dst")"
  cp -afv "$src" "$dst"
}

### 🗂 Directory Setup
create_directories() {
  printf "\n⌛... Creating default folders... 📂\n"
  mkdir -p "$HOME"/{channeling,mnt,aws}
  mkdir -p "${alchemy:?}"/{ingredients,summons}
  mkdir -p "${magic:?}/ingredients"
}

### 📝 File Setup
create_default_files() {
  printf "\n⌛... Creating default files... 📝\n"
  : > "$HOME/.zprofile"
  : > "$HOME/.secrets"
  : > "$HOME/.awsrc"
}

### 🧙 Clone Scripts Repo
setup_scripts_repo() {
  printf "\n⌛... Summoning scripts... 🧙\n"
  if [ ! -d "$alchemy/scripts" ]; then
    git clone https://gitlab.com/utzuro/scripts.git "$alchemy/scripts"
    (
      cd "$alchemy/scripts" || exit
      git remote remove origin || true
      git remote add origin git@gitlab.com:utzuro/scripts.git
    )
  else
    printf "✅ Scripts repo already exists. Skipping clone.\n"
  fi
}

### 🔗 Link Dotfiles
link_dotfiles() {
  printf "\n⌛... Linking configuration files to the corresponding places in the system... 🖇\n"

  printf "\n⌛... Linking vim configs... 📝\n"
  ln_sf_or_copy "$DIR/config/vim/.vimrc" "$HOME/.vimrc"

  mkdir -p "$HOME/.config/nvim"
  ln_sf_or_copy "$DIR/config/vim/nvim/init.vim" "$HOME/.config/nvim/init.vim"

  ln_sf_or_copy "$DIR/config/vim/.ideavimrc" "$HOME/.ideavimrc"

  mkdir -p "$HOME/.vim"
  for file in "$DIR"/config/vim/.vim/*.vim; do
    ln_sf_or_copy "$file" "$HOME/.vim/$(basename "$file")"
  done

  # Remove spellcheck from commented out lines
  mkdir -p "$HOME/.vim/after/syntax"
  ln_sf_or_copy "$DIR/config/vim/.vim/after/syntax/asciidoc.vim" "$HOME/.vim/after/syntax/asciidoc.vim"

  printf "📝 Installing vim plugins... 🚀\n"
  (have_cmd vim && vim +PlugInstall +qall) || true
  (have_cmd nvim && nvim +PlugInstall +qall) || true
}

### 🛠 Shell & Tool Setup (if not using Home Manager)
manual_shell_and_tools() {
  if [ ! -x "$HOME/.nix-profile/bin/home-manager" ]; then
    printf "\n⌛... Nix not detected — installing shell tools manually... 🛠\n"
    printf "\n⌛... Linking shell configs... 🖥\n"

    mkdir -p "$HOME/.config/mpd"
    ln_sf_or_copy "$DIR/config/mpd/"* "$HOME/.config/mpd/" || true

    ln_sf_or_copy "$DIR/config/.bashrc" "$HOME/.bashrc"
    ln_sf_or_copy "$DIR/config/tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln_sf_or_copy "$DIR/config/zsh/.zshrc" "$HOME/.zshrc"
    ln_sf_or_copy "$DIR/config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

    printf "\n⌛... Getting ready files that shouldn't be linked... 🌐\n"
    : > "$HOME/.profile"

    # Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
      RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
      printf "📝 Oh My Zsh already installed.\n"
    fi

    # zplug
    if [ ! -d "$HOME/.zplug" ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
      printf "📝 Run 'zplug install' to install plugins.\n"
    else
      printf "📝 Zplug already installed.\n"
    fi

    # tmux plugin manager
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
      git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
      printf "📝 Install tmux plugins with Ctrl+B I\n"
    else
      printf "📝 TPM already installed.\n"
    fi

    printf "\n⌛... Linking terminal tools configs... 🖥\n"
    mkdir -p "$HOME/.config/ncmpcpp"
    ln_sf_or_copy "$DIR/config/ncmpcpp/"* "$HOME/.config/ncmpcpp/" || true

    mkdir -p "$HOME/.config/ranger"
    if [ ! -d "$HOME/.config/ranger/plugins/ranger_devicons" ]; then
      git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"
    fi
    ln_sf_or_copy "$DIR/config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

    mkdir -p "$HOME/.config/kitty"
    ln_sf_or_copy "$DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

    printf "\n⌛... Installing and configuring OS-agnostic packages... 📦\n"
    "$DIR/packages/osagnostic.sh"
  fi
}

### 🔐 SSH Config
setup_ssh() {
  printf "\n⌛... Linking SSH config... 🔑\n"
  mkdir -p "$HOME/.ssh"
  if [ -f "$DIR/config/ssh/config" ]; then
    # don’t overwrite an existing config
    cp -n "$DIR/config/ssh/config" "$HOME/.ssh/config" || true
  fi

  if [ ! -f "$HOME/.ssh/utzuro" ]; then
    ssh-keygen -f "$HOME/.ssh/utzuro" -N ''
  fi
}

### 🖼 Misc files
link_images() {
  printf "\n⌛... Linking image files... 🖇\n"
  ln_sf_or_copy "$DIR/ingr/i/.face" "$HOME/.face" || true
  ln_sf_or_copy "$DIR/ingr/i/background.png" "$HOME/background.png" || true
}

### 🐚 Default shell handling
configure_default_shell() {
  if ! $is_msys2; then
    if have_cmd zsh; then
      zsh_path="$(command -v zsh)"
      printf "%s\n" "$zsh_path" | sudo_safe tee -a /etc/shells >/dev/null || true
      sudo_safe chsh -s "$zsh_path" "${USER}" || true
    fi
    return
  fi

  # On MSYS2: no system chsh. Make zsh the interactive default by exec’ing from bash profile.
  if have_cmd zsh; then
    if ! grep -q 'exec zsh -l' "$HOME/.bash_profile" 2>/dev/null; then
      printf "\n# Auto-start zsh in MSYS2 shells\nexec zsh -l\n" >> "$HOME/.bash_profile"
      printf "✅ MSYS2: will start zsh automatically when opening your shell.\n"
    fi
  fi
}

### 🚀 Run All
main() {
  create_directories
  create_default_files
  setup_scripts_repo
  link_dotfiles
  link_images
  manual_shell_and_tools
  setup_ssh
  configure_default_shell
  printf "\n🔥 Shell tools installation complete! 🔥\n"
}

main "$@"

