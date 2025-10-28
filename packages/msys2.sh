#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log(){ printf "🔹 %s\n" "$*"; }
good(){ printf "✅ %s\n" "$*"; }
warn(){ printf "⚠️  %s\n" "$*"; }
fail(){ printf "❌ %s\n" "$*"; exit 1; }

command -v pacman >/dev/null 2>&1 || fail "pacman not found. Run this inside MSYS2."

echo
echo "⌛... Installing all the packages for MSYS2... 🖳"

: "${MSYSTEM:=MSYS}"
case "${MSYSTEM^^}" in
  UCRT64)  MINGW_ROOT="/ucrt64";  MINGW_PKGPFX="mingw-w64-ucrt-x86_64" ;;
  MINGW64) MINGW_ROOT="/mingw64"; MINGW_PKGPFX="mingw-w64-x86_64" ;;
  CLANG64) MINGW_ROOT="/clang64"; MINGW_PKGPFX="mingw-w64-clang-x86_64" ;;
  MSYS|*)  MINGW_ROOT="/ucrt64";  MINGW_PKGPFX="mingw-w64-ucrt-x86_64"; warn "In MSYS shell; defaulting native toolchain to UCRT64." ;;
esac
log "Detected MSYSTEM: ${MSYSTEM} (toolchain prefix: ${MINGW_PKGPFX})"

pac_freshen_and_retry(){
  local attempt=1
  while (( attempt <= 3 )); do
    if pacman --noconfirm "$@"; then return 0; fi
    warn "pacman failed (attempt $attempt). Forcing DB refresh…"
    pacman --noconfirm -Syy || true
    ((attempt++))
  done
  fail "pacman failed after multiple attempts."
}

log "Updating package databases and performing full upgrade…"
pacman --noconfirm -Syy
pac_freshen_and_retry -Syu || true
pac_freshen_and_retry -Syu || true

MSYS_PACKAGES=(
  bash coreutils findutils grep gawk sed tar gzip xz zstd zip unzip p7zip
  diffutils file which less bc
  git openssh curl wget ca-certificates
  make pkgconf jq rsync tree tmux vim
)

MINGW_COMMON=(
  "zsh"
  "${MINGW_PKGPFX}-toolchain"
  "${MINGW_PKGPFX}-cmake"
  "${MINGW_PKGPFX}-scdoc"
  "${MINGW_PKGPFX}-ninja"
  "${MINGW_PKGPFX}-pkgconf"
  "${MINGW_PKGPFX}-gdb"
  "${MINGW_PKGPFX}-make"
  "${MINGW_PKGPFX}-python"
  "${MINGW_PKGPFX}-python-pip"
  "${MINGW_PKGPFX}-neovim"
  "${MINGW_PKGPFX}-eza"
  "${MINGW_PKGPFX}-nerd-fonts"
  "${MINGW_PKGPFX}-ttf-nerd-fonts-symbols"
  "${MINGW_PKGPFX}-jq"
  "${MINGW_PKGPFX}-ripgrep"
  "${MINGW_PKGPFX}-fd"
  "${MINGW_PKGPFX}-fzf"
  "${MINGW_PKGPFX}-openssl"
  "${MINGW_PKGPFX}-zlib"
  "${MINGW_PKGPFX}-brotli"
  "${MINGW_PKGPFX}-libarchive"
  "${MINGW_PKGPFX}-icu"
  "${MINGW_PKGPFX}-graphviz"
  "${MINGW_PKGPFX}-sqlite3"
)

MINGW_NODESET=( "${MINGW_PKGPFX}-nodejs" "${MINGW_PKGPFX}-yarn" )
MINGW_GOSET=( "${MINGW_PKGPFX}-go" )

log "🔧 Installing MSYS userland packages…"
pac_freshen_and_retry -S --needed "${MSYS_PACKAGES[@]}"

log "🛠  Installing native ${MSYSTEM^^} toolchain & dev stack…"
pac_freshen_and_retry -S --needed "${MINGW_COMMON[@]}"

read -r -p "📦 Install Node.js + npm + yarn (native ${MSYSTEM^^})? (y/N) " yn_node
if [[ "${yn_node,,}" == "y" ]]; then
  pac_freshen_and_retry -S --needed "${MINGW_NODESET[@]}"
fi

read -r -p "📦 Install Go toolchain (native ${MSYSTEM^^})? (y/N) " yn_go
if [[ "${yn_go,,}" == "y" ]]; then
  pac_freshen_and_retry -S --needed "${MINGW_GOSET[@]}"
fi

PROFILE_D="/etc/profile.d/99-bootstrap-path.sh"
if [ ! -f "$PROFILE_D" ] || ! grep -q "bootstrap msys2 path shim" "$PROFILE_D"; then
  log "Configuring PATH shim in ${PROFILE_D}…"
  cat > "$PROFILE_D" <<'EOF'
# >>> bootstrap msys2 path shim >>>
if [ -n "$MSYSTEM" ]; then
  case "${MSYSTEM^^}" in
    UCRT64)  __pref="/ucrt64/bin" ;;
    MINGW64) __pref="/mingw64/bin" ;;
    CLANG64) __pref="/clang64/bin" ;;
    *)       __pref="" ;;
  esac
  if [ -n "$__pref" ] && ! echo "$PATH" | tr ":" "\n" | grep -qx "$__pref"; then
    export PATH="$__pref:$PATH"
  fi
  unset __pref
fi
# <<< bootstrap msys2 path shim <<<
EOF
fi

git_config_safe(){
  local key="$1" val="$2"
  if ! git config --global --get "$key" >/dev/null 2>&1; then
    git config --global "$key" "$val"
  fi
}
log "Applying minimal global git config…"
git_config_safe core.autocrlf input
git_config_safe pull.rebase false
git_config_safe init.defaultBranch main

if [ ! -f "$HOME/.ssh/id_ed25519" ] && [ ! -f "$HOME/.ssh/id_rsa" ]; then
  log "Generating new SSH key (ed25519)…"
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519" -C "${USER:-msys2}@$(hostname)"
  good "SSH key created at ~/.ssh/id_ed25519"
else
  log "SSH key already present, skipping."
fi

if ! command -v vim >/dev/null 2>&1 && command -v nvim >/dev/null 2>&1; then
  log "Creating vim shim -> nvim"
  mkdir -p "$HOME/.local/bin"
  cat > "$HOME/.local/bin/vim" <<'EOF'
#!/usr/bin/env bash
exec nvim "$@"
EOF
  chmod +x "$HOME/.local/bin/vim"
  if ! echo "$PATH" | tr ":" "\n" | grep -qx "$HOME/.local/bin"; then
    printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$HOME/.bashrc"
  fi
fi

if ! grep -q "VIRTUAL_ENV_DISABLE_PROMPT" "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'EOF'

export PIP_DISABLE_PIP_VERSION_CHECK=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
alias venv="python -m venv .venv && . .venv/bin/activate"
EOF
fi

echo
good "MSYS userland installed."
good "Native toolchain (${MSYSTEM^^}) installed under ${MINGW_ROOT}."
echo "   • Open the '${MINGW_ROOT#/}' shell for native builds."
echo "   • Keep current with:  pacman -Syu"
good "MSYS2 setup complete! 🔥"

