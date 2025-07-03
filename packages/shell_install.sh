#!/usr/bin/env bash

alchemy="$HOME/alchemy"
magic="$HOME/magic"

CURDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
cd "$DIR" || exit
DIR="$CURDIR/.."

printf "\n⌛... Creating default folders... 📂\n"
mkdir ~/{channeling,mnt}
mkdir -p "${alchemy:?}"/{ingredients,summons} ${magic:?}/ingredients "$HOME"/aws

printf "\n⌛... Creating default files... 📝\n"
touch "${HOME:?}"/.profile
touch "${HOME:?}"/.zprofile
touch "${HOME:?}"/.secrets
touch "${HOME:?}"/.awsrc

printf "\n⌛... Summoning scripts... 🧙\n"
if ! [ -d "$alchemy"/scripts ]; then
  git clone https://gitlab.com/utzuro/scripts.git "$alchemy"/scripts
  cd "$alchemy"/scripts || exit
  git remote remove origin
  git remote add origin git@gitlab.com:utzuro/scripts.git
  cd "$DIR" || exit
fi

printf "\n⌛... Linking configuration files to the corresponding places in the system... 🖇\n"

printf "\n⌛... Linking vim configs... 📝\n"
ln -sfv "$DIR"/config/vim/.vimrc "$HOME"/
mkdir "$HOME"/.config/nvim
ln -sfv "$DIR"/config/vim/nvim/init.vim "$HOME"/.config/nvim/init.vim
# TODO: Move configs to lua
# mkdir -p "$HOME"/.config/nvim/lua/utils
# ln -sfv "$DIR"/config/vim/nvim/init.lua "$HOME"/.config/nvim/
# ln -sfv "$DIR"/config/vim/nvim/lua/*.lua "$HOME"/.config/nvim/lua/
# ln -sfv "$DIR"/config/vim/nvim/lua/utils/*.lua "$HOME"/.config/nvim/lua/utils/
ln -sfv "$DIR"/config/vim/.ideavimrc "$HOME"/
ln -sfv "$DIR"/config/vim/.vim/*.vim "$HOME"/.vim/

# Hack to avoid spellchecking in comments
mkdir -p "$HOME"/.vim/after/syntax
ln -sfv "$DIR"/config/vim/.vim/after/syntax/asciidoc.vim "$HOME"/.vim/after/syntax/

printf "📝 Installing vim plugins... 🚀\n"
vim +PlugInstall +qall
nvim +PlugInstall +qall

# ignore dots that are already defined with HomeManager on nix
if [ ! -d "$HOME"/.nix-profile ]; then

    printf "\n⌛... Nix wasn't detected, so installing shell tools manually... 🛠\n"

    print "\n⌛... working on shell... 🖥\n"
    ln -sfv "$DIR"/config/zsh/.zshrc "$HOME"/
    ln -sfv "$DIR"/config/zsh/.p10k.zsh "$HOME"/
    ln -sfv "$DIR"/config/.bashrc "$HOME"/
    ln -sfv "$DIR"/config/tmux/.tmux.conf "$HOME"/
    
    if ! [ -d "$HOME/.oh-my-zsh" ]; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else printf "📝 Oh My Zsh seems to be already installed! Remove ~/.oh-my-zsh to reinstall. 🚀\n"
    fi

    if ! [ -d "$HOME/.zplug/" ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
      printf "📝 Install zsh plugins with zplug install! 🚀\n"
    else printf "📝 Zplug seems to be already installed! Remove ~/.zplug to reinstall. 🚀\n"
    fi

    if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      printf "📝 Install tmux plugins with ctrl+B + I 🚀\n"
    else printf "📝 TPM seems to be already installed! Remove ~/.tmux/plugins/tpm to reinstall. 🚀\n"
    fi

    print "\n⌛... working on tools... 🖥\n"
    ln -sfv "$DIR"/config/ncmpcpp/* "$HOME"/.config/ncmpcpp/

    if ! [ -d "$HOME/.config/ranger/plugins/ranger_devicons" ] && [ -d "$HOME/.config/ranger"  ]; then
      git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
    fi

    mkdir -p "$HOME"/.config/ranger
    ln -sfv "$DIR"/config/ranger/rc.conf "$HOME"/.config/ranger/rc.conf
    ln -sfv "$DIR"/config/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf

    printf "\n⌛... Installing and configuring OS agnostic pkgs... 📂\n"
    "$DIR"/packages/osagnostic.sh
fi

# Tools
# SSH
printf "\n⌛... Linking SSH config... 🔑\n"
mkdir -p "$HOME"/.ssh
cp -n "$DIR"/config/ssh/config "$HOME"/.ssh/
ssh-keygen -f ~/.ssh/utzuro -N ''

printf "\n⌛... Linking image files... 🖇\n"
ln -sfv "$DIR"/ingr/i/.face "$HOME"/
ln -sfv "$DIR"/ingr/i/background.png "$HOME"/

print "\n⌛... Installing Flatpak... 📦\n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak update

printf "\n🔥 Shell tools installation complete! 🔥\n"
