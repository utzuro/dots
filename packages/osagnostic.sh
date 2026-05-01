#!/usr/bin/env bash
set -euo pipefail

# rss
printf "\n⌛... Installing and configuring OS agnostic pkgs... 📂\n"

printf "\n⌛... installing NodeJS... 🖥\n"
if [ -d "$HOME/.nvm" ]; then
	echo "⏭️  nvm already installed at ~/.nvm, skipping install."
else
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
fi

source "$HOME/.nvm/nvm.sh"
nvm install 22
node -v

if command -v pnpm >/dev/null 2>&1; then
	echo "⏭️  pnpm already installed, skipping."
else
	wget -qO- https://get.pnpm.io/install.sh | sh -
fi

export GOPATH="$HOME/go"
mkdir -p "$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"

printf "\n⌛... installing Poetry for Python... 🖥\n"
if [ -d "$HOME/.local/share/pypoetry" ]; then
	echo "⏭️  poetry already installed at ~/.local/share/pypoetry, skipping."
else
	wget -qO- https://install.python-poetry.org | python3 -
fi

printf "\n⌛... installing pyenv for Python... 🖥\n"
if [ -d "$HOME/.pyenv" ]; then
	echo "⏭️  pyenv already installed at ~/.pyenv, skipping."
else
	wget -qO- https://pyenv.run | bash
fi

printf "\n⌛... installing RSS... 🖥\n"
go install github.com/TypicalAM/goread@latest || true

# Go-based tools
echo "📦 Installing Go-based dev tools..."
go install github.com/kyleconroy/sqlc/cmd/sqlc@latest || true
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest || true
go install github.com/fatih/gomodifytags@latest || true
go install github.com/josharian/impl@latest || true
go install github.com/rogpeppe/godef@latest || true

printf "\n⌛... installing dictionaries... 🖥\n"
go install github.com/masakichi/tango@latest || true
echo
echo "📝 Import Japanese dictionaries with: tango -import... 📚"
