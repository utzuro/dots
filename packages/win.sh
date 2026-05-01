#!/usr/bin/env bash
set -e

# --- Scoop bootstrap (PowerShell required) ---
# > Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# > irm get.scoop.sh | iex
# To customize install
# > irm get.scoop.sh -outfile 'install.ps1'
# > .\install.ps1 -ScoopDir 'A:\scoop' -ScoopGlobalDir 'A:\scoop-global'

echo "⌛... Installing packages for Windows (Scoop)... 🖳"

# Note: chat tools do not work well when installed with scoop, so omit them.

scoop bucket add extras

# --- Shell tools ---
scoop install neovim

# Temporary workaround to make Neovim config work on Windows.
rm -rf ~/AppData/Local/nvim
cp -r ~/alchemy/dots/config/vim/nvim ~/AppData/Local/
rm -rf ~/AppData/Local/nvim/colors
cp -r ~/alchemy/dots/config/vim/colors ~/AppData/Local/nvim/

scoop install eza fzf ripgrep
scoop install ffmpeg vim neovim 7zip curl wget openssh coreutils yt-dlp

scoop install opencode

# --- Development tools ---
scoop install python go protobuf nodejs rustup cmake
scoop install mingw grpc-tools grpcurl

# --- GUI tools ---
# scoop install libreoffice qbittorrent vlc sumatrapdf anki
scoop install kitty nu wezterm alacritty # can't decide which to use
scoop install vscode
scoop install dbeaver

# --- Notes for NixOS WSL ---
# WezTerm config:
# return {
#   default_prog = { "wsl.exe", "-d", "NixOS" },
# }

# Alacritty config:
# shell:
#   program: "wsl"
#   args: ["-d", "NixOS"]

# --- Windows utilities ---
# scoop install powertoys ueli wiztree
# scoop install sumatrapdf eartrumpet

# --- Games ---
# scoop bucket add versions
# scoop install steam

# Run with admin rights (buckets can be installed as normal user).
# scoop bucket add games
# scoop bucket add nonportable
# scoop install protonvpn-np
# scoop install epic-games-launcher
# scoop install voicemeeter-np
echo "✅ Windows package installation complete!"

echo 'Install vim-plug for vim:
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force'

echo 'Install vim-plug for neovim:
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force'
