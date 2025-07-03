# Install scoop as package manager (powershell req):
# > Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# > irm get.scoop.sh | iex

# note: chats don't work well when installed with scoop, so omit those

scoop bucket add extras 

# tools (normally installed with nix)
scoop install neovim
scoop install python go protobuf nodejs rustup cmake
scoop install ffmpeg vim neovim 7zip curl wget openssh coreutils yt-dlp
scoop install libreoffice qbittorrent vlc sumatrapdf anki eartrumpet 
scoop install kitty wezterm alacritty
scoop install jetbrains-toolbox

# wezterm config:
# return {
#   default_prog = { "wsl.exe", "-d", "NixOS" },
# }

# alacritty config:
# shell:
#   program: "wsl"
#   args: ["-d", "NixOS"]



# win-utils
scoop install ahkpm powertoys ueli wiztree
scoop install sumatrapdf eartrumpet 

# games
# scoop bucket add versions
# scoop install steam

# run with admin rights (buckets can be installed as normal user)
# scoop bucket add games
# scoop bucket add nonportable 
# scoop install protonvpn-np 
# scoop install epic-games-launcher
# scoop install voicemeeter-np 
