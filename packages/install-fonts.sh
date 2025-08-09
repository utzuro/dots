mkdir -p ~/.local/share/fonts

# Main font
cd /tmp
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -o Hack.zip -d ~/.local/share/fonts

# Symbols-only font (v3+ is important)
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip -o NerdFontsSymbolsOnly.zip -d ~/.local/share/fonts

fc-cache -fv

