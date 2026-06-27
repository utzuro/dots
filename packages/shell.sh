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

home_manager_detected() {
	have_cmd home-manager || [ -x "$HOME/.nix-profile/bin/home-manager" ]
}

copy_replace() {
	local source="$1"
	local destination="$2"
	local destination_parent

	destination_parent="$(dirname "$destination")"
	mkdir -p "$destination_parent"

	if [ -d "$source" ] && [ ! -L "$source" ]; then
		rm -rf "$destination"
		cp -R "$source" "$destination"
	else
		rm -f "$destination"
		cp "$source" "$destination"
	fi

	printf "copied '%s' -> '%s'\n" "$source" "$destination"
}

link_or_copy() {
	local source="$1"
	local destination="$2"
	local destination_parent

	destination_parent="$(dirname "$destination")"
	mkdir -p "$destination_parent"

	if ln -sfnv "$source" "$destination"; then
		return
	fi

	printf "link failed; copying '%s' -> '%s'\n" "$source" "$destination"
	copy_replace "$source" "$destination"
}

# Safe sudo wrapper: no sudo on MSYS2, so just run the cmd (or warn)
sudo_safe() {
	if $is_msys2; then
		# MSYS2 doesn’t typically have sudo; most ops should be user-level
		"$@"
	else
		if have_cmd sudo; then sudo "$@"; else "$@"; fi
	fi
}

windows_path() {
	if have_cmd cygpath; then
		cygpath -u "$1"
	else
		printf "%s\n" "${1//\\//}"
	fi
}

link_nushell_configs_to() {
	local nushell_dir="$1"
	mkdir -p "$nushell_dir/autoload"
	ln -sfv "$DIR/config/nushell/config.nu" "$nushell_dir/config.nu"
	ln -sfv "$DIR/config/nushell/env.nu" "$nushell_dir/env.nu"
	ln -sfv "$DIR/config/nushell/autoload/zoxide.nu" "$nushell_dir/autoload/zoxide.nu"
}

link_nushell_configs() {
	printf "\n⌛... Linking nushell configs... 📝\n"
	link_nushell_configs_to "$HOME/.config/nushell"
	if [ -n "${APPDATA:-}" ]; then
		link_nushell_configs_to "$(windows_path "$APPDATA")/nushell"
	fi
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
	touch "$HOME/.zprofile" "$HOME/.secrets" "$HOME/.awsrc"
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

	# Extra configs
	mkdir -p ~/.config

	printf "\n⌛... Linking GnuPG configs... 📝\n"
	mkdir -p "$HOME/.gnupg/"
	link_or_copy "$DIR/config/gnupg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
	link_or_copy "$DIR/config/gnupg/scdaemon.conf" "$HOME/.gnupg/scdaemon.conf"

	printf "\n⌛... Linking WSL configs... 📝\n"
	link_or_copy "$DIR/config/win/.wslconfig" "$HOME/.wslconfig"
	link_or_copy "$DIR/config/.bash_profile" "$HOME/.bash_profile"
	link_or_copy "$DIR/config/.bashrc" "$HOME/.bashrc"

	printf "\n⌛... Linking nix configs... 📝\n"
	rm -rf "$HOME/.config/nix"
	link_or_copy "$DIR/config/nix" "$HOME/.config/nix"

	printf "\n⌛... Linking npm configs... 📝\n"
	ln -sfv "$DIR/config/npm/.npmrc" "$HOME/.npmrc"

	printf "\n⌛... Linking vim configs... 📝\n"
	link_or_copy "$DIR/config/vim/vimrc" "$HOME/.vimrc"

	rm -rf "$HOME/.config/nvim"
	link_or_copy "$DIR/config/vim/nvim" "$HOME/.config/nvim"
	# workaround to avoid devcontainer error
	mkdir -p ~/.cache/nvim
	touch ~/.cache/nvim/devcontainer.log

	link_or_copy "$DIR/config/vim/ideavimrc" "$HOME/.ideavimrc"

	mkdir -p "$HOME/.vim"
	for file in "$DIR"/config/vim/vim/*.vim; do
		link_or_copy "$file" "$HOME/.vim/$(basename "$file")"
	done

	mkdir -p "$HOME/.vim/colors"
	for file in "$DIR"/config/vim/colors/*.vim; do
		link_or_copy "$file" "$HOME/.vim/colors/$(basename "$file")"
	done

	# Remove spellcheck from commented out lines
	mkdir -p "$HOME/.vim/after/syntax"
	link_or_copy "$DIR/config/vim/vim/after/syntax/asciidoc.vim" "$HOME/.vim/after/syntax/asciidoc.vim"

	printf "\n⌛... Linking hx configs... 📝\n"
	mkdir -p "$HOME/.config/helix"
	link_or_copy "$DIR/config/helix/config.toml" "$HOME/.config/helix/config.toml"
	mkdir -p "$HOME/.config/helix/themes"
	link_or_copy "$DIR/config/helix/themes/void.toml" "$HOME/.config/helix/themes/void.toml"

	printf "\n⌛... Linking jj configs... 📝\n"
	mkdir -p "$HOME/.config/jj"
	link_or_copy "$DIR/config/jj/config.toml" "$HOME/.config/jj/config.toml"

	printf "\n⌛... Linking yazi configs... 📝\n"
	mkdir -p "$HOME/.config/yazi/plugins"
	link_or_copy "$DIR/config/yazi/init.lua" "$HOME/.config/yazi/init.lua"
	link_or_copy "$DIR/config/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
	link_or_copy "$DIR/config/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
	yazi_plugin="$HOME/.config/yazi/plugins/minimal.yazi"
	if [ -e "$yazi_plugin" ] || [ -L "$yazi_plugin" ]; then
		rm -rf "$yazi_plugin"
	fi
	link_or_copy "$DIR/plugins/yazi/minimal.yazi" "$yazi_plugin"

	printf "\n⌛... Linking wezterm configs... 📝\n"
	mkdir -p "$HOME/.config/wezterm/colors"
	link_or_copy "$DIR/config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
	for file in "$DIR/config/wezterm/colors"/*.toml; do
		[ -f "$file" ] || continue
		link_or_copy "$file" "$HOME/.config/wezterm/colors/$(basename "$file")"
	done

	# Agents
	printf "\n⌛... Linking agents configs... 📝\n"
	mkdir -p "$HOME/.pi/agent/themes"
	link_or_copy "$DIR/config/pi/settings.json" "$HOME/.pi/agent/settings.json"
	link_or_copy "$DIR/config/pi/themes/void.json" "$HOME/.pi/agent/themes/void.json"
	link_or_copy "$DIR/config/agents/AGENTS.md" "$HOME/.pi/agent/AGENTS.md"
	mkdir -p "$HOME/.agents/skills"
	for skill in "$DIR"/config/agents/skills/*; do
		[ -e "$skill" ] || continue
		skill_name="$(basename "$skill")"
		destination="$HOME/.agents/skills/$skill_name"
		if [ -e "$destination" ] || [ -L "$destination" ]; then
			rm -rf "$destination"
		fi
		link_or_copy "$skill" "$destination"
	done
}

install_vim_plugins() {
	printf "📝 Installing vim plugins... 🚀\n"
	if ! have_cmd vim && ! have_cmd nvim; then
		printf "⚠️  Neither vim nor nvim found; skipping plugin install.\n"
		return
	fi

	if have_cmd zsh; then
		zsh -lc 'command -v vim >/dev/null 2>&1 && vim +PlugInstall +qall || true; command -v nvim >/dev/null 2>&1 && nvim +PlugInstall +qall || true'
	else
		(have_cmd vim && vim +PlugInstall +qall) || true
		(have_cmd nvim && nvim +PlugInstall +qall) || true
	fi
}

### 🛠 Shell & Tool Setup
manual_shell_and_tools() {
	printf "\n⌛... Configuring shell tools manually... 🛠\n"
	printf "\n⌛... Linking shell configs... 🖥\n"

	mkdir -p "$HOME/.config/mpd"
	ln -sfv "$DIR/config/mpd/"* "$HOME/.config/mpd/" || true

	link_or_copy "$DIR/config/.bash_profile" "$HOME/.bash_profile"
	link_or_copy "$DIR/config/.bashrc" "$HOME/.bashrc"
	link_or_copy "$DIR/config/tmux/.tmux.conf" "$HOME/.tmux.conf"
	link_or_copy "$DIR/config/zsh/.zshrc" "$HOME/.zshrc"
	link_or_copy "$DIR/config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

	printf "\n⌛... Getting ready files that shouldn't be linked... 🌐\n"
	touch "$HOME/.profile"

	# Oh My Zsh
	if have_cmd zsh; then
		if [ ! -d "$HOME/.oh-my-zsh" ]; then
			RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
				sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		else
			printf "📝 Oh My Zsh already installed.\n"
		fi
	fi

	# zplug
	if have_cmd zsh; then
		if [ ! -d "$HOME/.zplug" ]; then
			curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
			printf "📝 Zplug installed.\n"
			if [ -f "$HOME/.zplug/init.zsh" ]; then
				if ! zsh -lc 'source "$HOME/.zplug/init.zsh" && zplug install'; then
					printf "⚠️  Zplug install failed; continuing bootstrap.\n"
				fi
			else
				printf "⚠️  Zplug init script not found; skipping zplug install.\n"
			fi
		else
			printf "📝 Zplug already installed.\n"
		fi
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
	ln -sfv "$DIR/config/ncmpcpp/"* "$HOME/.config/ncmpcpp/" || true

	mkdir -p "$HOME/.config/ranger"
	if [ ! -d "$HOME/.config/ranger/plugins/ranger_devicons" ]; then
		git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"
	fi
	link_or_copy "$DIR/config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

	mkdir -p "$HOME/.config/kitty"
	link_or_copy "$DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

	printf "\n⌛... Installing and configuring OS-agnostic packages... 📦\n"
	"$DIR/packages/osagnostic.sh"
}

### 🔐 SSH Config
setup_ssh() {
	printf "\n⌛... Linking SSH config... 🔑\n"
	mkdir -p "$HOME/.ssh"
	if [ -f "$DIR/config/ssh/config" ]; then
		# don’t overwrite an existing config
		cp -n "$DIR/config/ssh/config" "$HOME/.ssh/config" || true
	fi

	if ! have_cmd ssh-keygen; then
		printf "⚠️  ssh-keygen not found; skipping SSH key setup.\n"
		return
	fi

	if [ ! -f "$HOME/.ssh/utzuro" ]; then
		ssh-keygen -f "$HOME/.ssh/utzuro" -N ''
	fi
}

### 🖼 Misc files
link_images() {
	printf "\n⌛... Linking image files... 🖇\n"
	ln -sfv "$DIR/ingr/i/.face" "$HOME/.face" || true
	ln -sfv "$DIR/ingr/i/background.jpg" "$HOME/background.jpg" || true
}

### 🐚 Default shell handling
configure_default_shell() {
	if ! $is_msys2; then
		if have_cmd zsh; then
			zsh_path="$(command -v zsh)"
			if ! grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
				printf "%s\n" "$zsh_path" | sudo_safe tee -a /etc/shells >/dev/null || true
			fi
			sudo_safe chsh -s "$zsh_path" "${USER}" || true
		fi
		return
	fi

	# On MSYS2: no system chsh. Make zsh the interactive default by exec’ing from bash profile.
	if have_cmd zsh; then
		if ! grep -q 'exec zsh -l' "$HOME/.bash_profile" 2>/dev/null; then
			printf "\n# Auto-start zsh in MSYS2 shells\nexec zsh -l\n" >>"$HOME/.bash_profile"
			printf "✅ MSYS2: will start zsh automatically when opening your shell.\n"
		fi
	fi
}

configure_without_home_manager() {
	if home_manager_detected; then
		printf "\n📝 Home-manager detected. Skipping manually managed shell configs and tools.\n"
		return
	fi

	link_nushell_configs
	manual_shell_and_tools
	configure_default_shell
}

### 🚀 Run All
main() {
	create_directories
	create_default_files
	setup_scripts_repo
	link_dotfiles
	link_images
	configure_without_home_manager
	install_vim_plugins
	setup_ssh
	printf "\n🔥 Shell tools installation complete! 🔥\n"
}

main "$@"
