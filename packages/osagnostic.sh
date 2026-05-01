#!/usr/bin/env bash
set -euo pipefail

printf "\n⌛... Installing and configuring OS-agnostic packages... 📦\n"

# --- Node.js toolchain ---
printf "\n⌛... Installing Node.js toolchain... 🖥\n"
if [ -d "$HOME/.nvm" ]; then
	echo "⏭️  nvm already installed at ~/.nvm, skipping install."
else
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
fi

if [ -s "$HOME/.nvm/nvm.sh" ]; then
	source "$HOME/.nvm/nvm.sh"
	nvm install 22
	nvm alias default 22
	node -v
else
	echo "⚠️  nvm init script not found; skipping Node.js setup."
fi

echo "📦 Installing pnpm package manager..."
if command -v pnpm >/dev/null 2>&1; then
	echo "⏭️  pnpm already installed, skipping."
else
	wget -qO- https://get.pnpm.io/install.sh | sh -
fi

export GOPATH="$HOME/go"
mkdir -p "$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"

# --- Python tooling ---
printf "\n⌛... Installing Python tooling... 🐍\n"
echo "📦 Installing Poetry..."
if [ -d "$HOME/.local/share/pypoetry" ]; then
	echo "⏭️  poetry already installed at ~/.local/share/pypoetry, skipping."
else
	wget -qO- https://install.python-poetry.org | python3 -
fi

echo "📦 Installing pyenv..."
if [ -d "$HOME/.pyenv" ]; then
	echo "⏭️  pyenv already installed at ~/.pyenv, skipping."
else
	wget -qO- https://pyenv.run | bash
fi

# --- Go tooling ---
printf "\n⌛... Installing Go tooling... 🐹\n"
echo "📦 Installing RSS reader tool (goread)..."
go install github.com/TypicalAM/goread@latest || true

echo "📦 Installing Go development tools..."
go install github.com/kyleconroy/sqlc/cmd/sqlc@latest || true
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest || true
go install github.com/fatih/gomodifytags@latest || true
go install github.com/josharian/impl@latest || true
go install github.com/rogpeppe/godef@latest || true

echo "📦 Installing dictionary tooling..."
go install github.com/masakichi/tango@latest || true
echo
echo "📝 Import Japanese dictionaries with: tango -import... 📚"
echo "✅ OS-agnostic package setup complete!"
