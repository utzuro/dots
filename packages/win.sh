# Install scoop as package manager (powershell req):
# > Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# > irm get.scoop.sh | iex
# To customize install
# > irm get.scoop.sh -outfile 'install.ps1'
# > .\install.ps1 -ScoopDir 'A:\scoop' -ScoopGlobalDir 'A:\scoop-global'

# note: chats don't work well when installed with scoop, so omit those

scoop bucket add extras

# shell
scoop install neovim

# Temp workaround to make it work on windows
rm -rf ~/AppData/Local/nvim
cp -r ~/alchemy/dots/config/vim/nvim ~/AppData/Local/
rm -rf ~/AppData/Local/nvim/colors
cp -r ~/alchemy/dots/config/vim/colors ~/AppData/Local/nvim/

scoop install eza fzf ripgrep
scoop install ffmpeg vim neovim 7zip curl wget openssh coreutils yt-dlp

scoop install opencode

# dev
scoop install python go protobuf nodejs rustup cmake
scoop install mingw grpc-tools grpcurl

# GUI
# scoop install libreoffice qbittorrent vlc sumatrapdf anki
scoop install kitty nu wezterm alacritty # can't decide which to use
scoop install vscode
scoop install dbeaver

# Notes for nixos wsl:
# wezterm config:
# return {
#   default_prog = { "wsl.exe", "-d", "NixOS" },
# }

# alacritty config:
# shell:
#   program: "wsl"
#   args: ["-d", "NixOS"]

# win-utils
# scoop install powertoys ueli wiztree
# scoop install sumatrapdf eartrumpet

# games
# scoop bucket add versions
# scoop install steam

# run with admin rights (buckets can be installed as normal user)
# scoop bucket add games
# scoop bucket add nonportable
# scoop install protonvpn-np
# scoop install epic-games-launcher
# scoop install voicemeeter-np
echo "All done!"

echo 'Install vim-plug for vim:
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force'

echo 'Install vim-plug for neovim:
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force'
