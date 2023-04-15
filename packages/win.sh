# WIP
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Install scoop as package manager (powershell req)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

scoop bucket add extra versions
scoop install ffmpeg vim 7zip curl wget sudo git openssh coreutils grep sed less
scoop install python ruby go nodejs
scoop instal neovim vscode docker docker-compose yt-dlp
