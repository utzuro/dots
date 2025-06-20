#!/usr/bin/env bash

set -e

repos=(
  # linux
  "https://github.com/torvalds/linux"
  "https://github.com/systemd/systemd"
  "https://github.com/i3/i3"
  "https://github.com/swaywm/sway"
  "https://github.com/hyprwm/Hyprland"
  "https://github.com/pulseaudio/pulseaudio"
  "https://github.com/git/git"
  "https://github.com/tmux/tmux"
  "https://github.com/tmux-plugins/tpm"
  "https://github.com/llvm/llvm-project"
  "https://github.com/gcc-mirror/gcc"
  "https://sourceware.org/git/glibc"
  "https://github.com/bminor/musl"
  "https://github.com/neovim/neovim"
  "https://github.com/vim/vim"
  "https://github.com/doomemacs/doomemacs"
  "https://github.com/nvim-telescope/telescope.nvim"
  "https://github.com/neoclide/coc.nvim"
  "https://github.com/junegunn/vim-plug"
  "https://github.com/pwmt/zathura"
  "https://github.com/pwmt/zathura-pdf-poppler"
  "https://github.com/pwmt/zathura-pdf-mupdf"
  "https://github.com/ncmpcpp/ncmpcpp"

  # databases and monitoring
  "https://github.com/postgres/postgres.git"
  "https://github.com/prometheus/prometheus.git"
  "https://github.com/grafana/grafana.git"

  # web servers and reverse proxies
  "https://github.com/nginx/nginx.git"
  "https://github.com/caddyserver/caddy.git"

  # distributed systems
  "https://github.com/etcd-io/etcd.git"
  "https://github.com/hashicorp/consul.git"
  "https://github.com/cockroachdb/cockroach.git"
  "https://github.com/bitcoin/bitcoin.git"

  # compilers and build tools
  "https://github.com/ghc/ghc.git"
  "https://github.com/minio/minio.git"
  "https://github.com/moby/moby.git"


  # prlangs
  "https://github.com/rust-lang/rust"
  "https://github.com/python/cpython"
  "https://github.com/NixOS/nix"
  "https://github.com/golang/go"
  
  # tools
  "https://github.com/containers/podman"
  "https://github.com/ranger/ranger"
  "https://github.com/ravachol/kew"
  "https://github.com/tauri-apps/tauri"
  "https://github.com/BurntSushi/ripgrep"
  "https://github.com/sharkdp/bat"
  "https://github.com/sharkdp/fd"
  "https://github.com/starship/starship"
  "https://github.com/junegunn/fzf"
  "https://github.com/redis/redis"
  "https://github.com/dragonflydb/dragonfly"
  "https://github.com/yt-dlp/yt-dlp"
  "https://github.com/nvbn/thefuck"
  "https://github.com/monero-project/monero"
  "https://github.com/kubernetes/kubernetes"
  "https://github.com/kovidgoyal/kitty"
  "https://github.com/DanteAlighierin/foot"
  "https://github.com/videolan/vlc"
  "https://github.com/mpv-player/mpv"

  # frameworks
  "https://github.com/fastapi/fastapi"
  "https://github.com/gin-gonic/gin"
  "https://github.com/spf13/cobra"
  
  # AI
  "https://github.com/pytorch/pytorch"
  "https://github.com/tensorflow/tensorflow"
  "https://github.com/huggingface/transformers"
  "https://github.com/ollama/ollama"

  # CS
  "https://github.com/TheAlgorithms/Python"

  # learn
  "https://github.com/justjavac/free-programming-books-zh_CN"
  "https://github.com/bregman-arie/devops-exercises"
  "https://github.com/bagder/http2-explained"
  "https://github.com/bagder/http3-explained"

  # communication tools and protocols
  "https://github.com/grpc/grpc"
  "https://github.com/matrix-org/synapse.git"
  "https://github.com/processone/ejabberd.git"
  "https://github.com/bjc/prosody.git"
  "https://github.com/asterisk/asterisk.git"
  "https://github.com/kamailio/kamailio.git"
  "https://github.com/eclipse/mosquitto.git"
  "https://github.com/zeromq/libzmq.git"
  "https://github.com/nats-io/nats-server.git"
  "https://github.com/mumble-voip/mumble.git"
  "https://github.com/quic-go/quic-go"
  "https://github.com/WireGuard/wireguard-linux"
  "https://github.com/WireGuard/wireguard-go"

  # AI
  "https://github.com/k2-fsa/sherpa-onnx"

  # games
  "https://github.com/vcmi/vcmi"
  "https://github.com/godotengine/godot"
  "https://github.com/ocornut/imgui"
  "https://github.com/bevyengine/bevy"
  # emulators
  "https://github.com/hrydgard/ppsspp"
  "https://github.com/RPCS3/rpcs3"
)

for repo in "${repos[@]}"; do
  repo_name=$(basename "$repo" .git)
  if [ ! -d "${repo_name}.git" ]; then
    echo "Cloning $repo..."
    git clone --depth=1 --single-branch --recurse-submodules "$repo" "${repo_name}.git"

  else
    echo "Updating $repo_name..."
    cd "${repo_name}.git" && git pull && git submodule update --depth=1 --recursive && cd ..

  fi
done

