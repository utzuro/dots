# WIP
# sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Install scoop as package manager (powershell req)
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# irm get.scoop.sh | iex

scoop bucket add extras 
# tools
scoop install ffmpeg vim 7zip curl wget sudo openssh coreutils yt-dlp
# utils
scoop install autohotkey powertoys
# apps
scoop install firefox libreoffice qbittorrent vlc sumatrapdf anki eartrumpet 
scoop install discord signal forkgram 
# dev
scoop install python go nodejs rustup 
scoop install neovim jetbrains-toolbox vscode docker docker-compose 
# games
scoop bucket add versions
scoop install steam

# run with admin rights (buckets can be installed as normal user)
scoop bucket add games
scoop bucket add nonportable 
# scoop install epic-games-launcher
# scoop install protonvpn-np voicemeeter-np 

