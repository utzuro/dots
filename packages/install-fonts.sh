#!/usr/bin/env bash
set -e

echo "⌛... Installing fonts... 🖋"

mkdir -p "$HOME/.local/share/fonts"

# --- Main font ---
cd /tmp
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -o Hack.zip -d "$HOME/.local/share/fonts"

# --- Symbols-only font (v3+ required) ---
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip -o NerdFontsSymbolsOnly.zip -d "$HOME/.local/share/fonts"

fc-cache -fv
echo "✅ Font installation complete!"
