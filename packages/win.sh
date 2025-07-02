# Install scoop as package manager (powershell req)
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# irm get.scoop.sh | iex

# note: chats don't work well when installed with scoop so install manually

scoop bucket add extras 
# tools
scoop install ffmpeg vim neovim 7zip curl wget openssh coreutils yt-dlp
# win-utils
scoop install ahkpm powertoys ueli wiztree openssh-connect
# apps
scoop install libreoffice qbittorrent vlc sumatrapdf anki eartrumpet 
# dev
scoop install python go nodejs rustup cmake

# games
# scoop bucket add versions
# scoop install steam

# run with admin rights (buckets can be installed as normal user)
# scoop bucket add games
# scoop bucket add nonportable 
# scoop install protonvpn-np 
# scoop install epic-games-launcher
# scoop install voicemeeter-np 

