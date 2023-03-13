echo
echo "⌛... Installing all the packages for the archlinux... 🖳"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# Update
sudo pacman -Syu --noconfirm --sudoloop

# Get essentials:
sudo pacman -S base-devel linux linux-headers linux-firmware lvm2 sudo intel-ucode --noconfirm
sudo pacman -S coreutils ntp grub efibootmgr dosfstools mtools cmake xsettingsd pasystray dhcpcd wpa_supplicant iw iwd --noconfirm
sudo pacman -S zsh ack peco imagemagick foremost asciidoctor maim net-tools lshw rsync rtorrent progress jq --noconfirm
sudo pacman -S man-db man-pages texinfo git git-lfs tmux openssh sshfs wget mpv mpd mpc ncmpcpp tree zip unzip htop --noconfirm 

# To get yay
if ! command -v yay &> /dev/null
then
  echo "⌛... Installing yay to get even more packages!🚀"
  tempdir="temp_yay_install_folder"
  if [ -d "$DIR/$tempdir" ];
  then
    rm -rf "${DIR:?}/${tempdir:?}"
  fi
  git clone https://aur.archlinux.org/yay.git "${DIR:?}/${tempdir:?}"
  cd "${DIR:?}"/"${tempdir:?}" || exit
  yes | makepkg -si
  cd "${DIR:?}" || exit
  rm -rf "${DIR:?}/${tempdir:?}"
fi

# Update just in case
yay -Syu --noconfirm --sudoloop

# Get paru
paru -S paru --noconfirm --sudoloop

# WM Essentials
paru -S polkit-gnome ffmpeg --noconfirm

# Wayland
paru -S hyprland-bin dunst rofi pavucontrol wl-clipboard wf-recorder swaybg grimblast-git ffmpegthumbnailer tumbler playerctl noise-suppression-for-voice thunar-archive-plugin kitty waybar-hyprland wlogout swaylock-effects sddm-git nwg-look-bin nordic-theme papirus-icon-theme pamixer --noconfirm

# Xorg and tools
sudo pacman -S xorg xorg-xinit xclip xsel xss-lock xorg-xbacklight xf86-input-libinput i3 picom arandr 

# WM Tools
dunst rofi gvim neovim redshift viewnior feh xfce4-terminal konsole kitty --noconfirm

# GUI Apps
sudo pacman -S thunar firefox chromium vlc gedit nautilus --noconfirm

# Dev tools
pacman -S docker docker-compose go goenv php node python

# Japanese input
sudo pacman -S uim ibus libmtp ninja clang --noconfirm

# Sound:
sudo pacman -S alsa-lib alsa-plugins alsa-utils pavucontrol pulseaudio pulseaudio-alsa lib32-alsa-plugins lib32-libpulse --noconfirm

# Graphics:
sudo pacman -S xf86-video-intel mesa lib32-mesa vulkan-intel --noconfirm


# Work with Documents
sudo pacman -S anki zathura zathura-cb zathura-djvu zathura-pdf-mupdf sdcv calibre --noconfirm

# Enable battery manager:
if [[ $(upower --enumerate 2>/dev/null | ack battery) =~ battery ]]; then
  sudo pacman -S acpi tlp --noconfirm
  systemctl enable --now tlp
fi

# Set up bluetooth:
sudo pacman -S bluez bluez-utils bluez-plugins --noconfirm
systemctl enable --now bluetooth

# Get fonts
## Favorite fonts
paru -S ttf-anonymous-pro adobe-source-code-pro-fonts noto-fonts  --noconfirm
## Japanese
paru -S adobe-source-han-sans-jp-fonts --noconfirm
## Handwriting fonts
paru -S ttf-quintessential otf-miama --noconfirm
## Backwards compatibility fonts
paru -S ttf-liberation  --noconfirm
## Icons
paru -S ttf-font-awesome nerd-fonts-complete powerline-fonts --noconfirm
## Just in case fonts
paru -S ttf-ancient-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji --noconfirm
## Just for fun fonts
paru -R ttf-macedonian-church

# Get Nvidia driver, nvidia realated tools and libraries for games
if [[ $(lshw -C display 2>/dev/null | ack vendor) =~ Nvidia ]]; then
  paru -S nvidia nvidia-utils nvidia-xrun nvidia-docker nvidia-docker-compose bbswitch lib32-nvidia-utils lib32-openal lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite
fi

# Get aur utils:
paru -S ntfs-3g bumblebee-status ddgr transfer.sh yt-dlp pipe-viewer-git python-myougiden zinnia ranger-sixel --noconfirm

# Network
paru -S tor protonvpn-cli openvpn --noconfirm

# IDE from aur
paru -S nvim python-pynvim nvimpager nvim-packer-git --noconfirm
#paru -S goland goland-jre pycharm-community-eap --noconfirm

# System monitors
paru -S i7z iotop powertop --noconfirm

# for rofi:
paru -S clerk-git copyq rofi-bluetooth-git rofi-search-git rofi-calc --noconfirm

# for bumblebee:
paru -S xininfo-git slop imgurbash2 filebin openssh ix progress python-requests --noconfirm

# Convert audiable to mp3
paru -S aaxtomp3 --noconfirm #--authcode 55b7ab34

# Work with Android:
paru -S android-tools simple-mtpfs adbfs-rootless-git --noconfirm

# Get chats and other
paru -S telegram-desktop discord zoom --noconfirm

# GUI tools
paru -S qbittorrent-enhanced-git --noconfirm

# Get creative
paru -S simplescreenrecorder-git audio-recorder cplay gimp inkscape krita obsidian-appimage --noconfirm

# Make gui look good:
paru -S qt5ct lxappearance adwaita-qt materia-gtk-theme --noconfirm

# Get office in need:
#paru -S libreoffice-fresh-ja hunspell hunspell-en_US hunspell-uk hunspell-ru libmythes libreoffice-extension-languagetool --noconfirm

# Games
read -rp "👾 Is this gaming PC? (y/N) 👀  " yn
if [ "$yn" == "y" ];
 then
  ## Get emulators:
  paru -S steam wine-staging winetricks wine-gecko wine-mono --noconfirm
  ## Libraries for the wine to work properly
  paru -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba --noconfirm
  ## Dosbox
  paru -S dosbox doomsday --noconfirm
  ## PlayStation
  paru -S duckstation-git pcsx2 rpcs3-git --noconfirm
  ## Other consoles (genesis, neko-project
  paru -S xnp2 assimp --noconfirm
  ## Virtual box
  paru -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle --noconfirm
fi

# Dev tools from aur
paru -S graphviz --noconfirm

echo
echo "🔥Archlinux installation complete!🔥"
