echo "⌛... Installing all the packages for the archlinux... 🖳"

# Get essentials:
sudo pacman -S ack imagemagick coreutils asciidoctor maim net-tools lshw polkit

# Install everything and preconfigured system (light packages)
???paru -S base-devel linux linux-headers linux-firmware lvm2 sudo intel-ucode xclip cmake man-db man-pages texinfo gvim git git-lfs tmux openssh sshfs wget mpv mpd ncmpcpp tree unzip unrar htop rsync ranger rtorrent uim ibus zinnia libmtp ninja clang progress firefox chromium vlc gedit kate nautilus redshift sxiv feh arandr imagemagick stow konsole asciidoctor xf86-input-libinput adobe-source-han-sans-jp-fonts ttf-font-awesome ttf-anonymous-pro ntfs-3g clerk-git copyq rofi-search-git rofi-calc android-tools simple-mtpfs adbfs-rootless-git anki zathura zathura-cb zathura-djvu zathura-pdf-mupdf calibre epub2txt epub2pdf pdf2png sdcv goldendict poppler html2pdf telegram-desktop telegram-tg-git discord slack-desktop zoom youtube-dl pipe-viewer-git obs-studio cplay gimp inkscape krita libreoffice-fresh-ja hunspell hunspell-en_US hunspell-uk hunspell-ru libmythes libreoffice-extension-languagetool docker docker-compose steam wine-staging wine-gecko wine-mono winetricks dosbox python-myougiden indicator-stickynotes virtualbox virtualbox-guest-iso virtualbox-ext-oracle i7z intel-undervolt powertop bumblebee-status polkit googler ddgr zoxide transfer.sh rofi polybar iotop bind indicator-stickynotes go php elixir

# Dev tools
pacman -S docker docker-compose

# i3 and tools
sudo pacman -S xorg xorg-xinit xclip xsel xss-lock xorg-xbacklight xf86-input-libinput i3 picom dunst rofi gvim arandr redshift sxiv feh

# Japanese input
sudo pacman -S uim ibus zinnia libmtp ninja clang

# Sound:
sudo pacman -S alsa-lib alsa-plugins alsa-utils pavucontrol pulseaudio pulseaudio-alsa lib32-alsa-plugins lib32-libpulse

# Graphics:
sudo pacman -S xf86-video-intel mesa lib32-mesa vulkan-intel

# Apps:
sudo pacman -S firefox chromium vlc gedit nautilus

# Work with Documents
sudo pacman -S anki zathura zathura-cb zathura-djvu zathura-pdf-mupdf sdcv calibre

# Enable battery manager:
if [[ $(upower --enumerate 2>/dev/null | ack battery) =~ battery ]]; then
  sudo pacman -S acpi tlp
  systemctl enable --now tlp
fi

# Get bluetooth:
sudo pacman -S bluez bluez-utils bluez-plugins

# To get paru
echo "⌛... Installing paru to get even more packages!🚀"
tempdir="temp_paru_install_folder"
rm -rf "${DIR:?}/${tempdir:?}"
git clone https://aur.archlinux.org/paru.git "${DIR:?}/${tempdir:?}"
cd "${DIR:?}"/"${tempdir:?}" || exit
makepkg -si
cd "${DIR:?}" || exit
rm -rf "${DIR:?}/${tempdir:?}"

# Get fonts
paru -S ttf-anonymous-pro ttf-liberation ttf-font-awesome adobe-source-han-sans-jp-fonts otf-ipafont terminus-font bdf-unifont font-bh-ttf ttf-bitstream-vera ttf-dejavu ttf-opensans noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji ttf-ubuntu-font-family ttf-ancient-fonts ttf-font-icons ttf-font-logos otf-ipaexfont otf-ipafont otf-ipamjfont

# Get Nvidia driver, nvidia realated tools and libraries for games
if [[ $(lshw -C display 2>/dev/null | ack vendor) =~ Nvidia ]]; then
  paru -S nvidia nvidia-utils nvidia-xrun nvidia-docker nvidia-docker-compose bbswitch lib32-nvidia-utils lib32-openal lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite
fi

# Get aur utils:
paru -S ntfs-3g bumblebee-status ddgr transfer.sh

# System monitors
paru -S i7z iotop powertop

# for rofi:
paru -S clerk-git copyq rofi-bluetooth-git rofi-search-git rofi-calc

# for bumblebee:
paru -S xininfo-git ffmpeg slop copyq imgurbash2 filebin openssh ix progress

# Convert audiable to mp3
paru -S aaxtomp3 #--authcode 55b7ab34

# Work with Android:
paru -S android-tools simple-mtpfs adbfs-rootless-git


# Get chats and other
paru -S telegram-desktop telegram-tg-git discord slack-desktop zoom youtube-dl pipe-viewer-git

# Get creative
paru -S simplescreenrecorder-git audio-recorder cplay lmms gimp inkscape krita blender

# Make gui look good:
paru -S qt5ct lxappearance adwaita-qt materia-gtk-theme

# Get office in need:
paru -S libreoffice-fresh-ja hunspell hunspell-en_US hunspell-uk hunspell-ru libmythes libreoffice-extension-languagetool

# Games
read -rp "👾 Is this gaming PC? (y/n) 👀" yn
if [ "$yn" == "y" ];
 then
  ## Get emulators:
  sudo pacman -S steam wine-staging winetricks wine-gecko wine-mono
  ## Libraries for the wine to work properly
  sudo pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba
  ## Dosbox
  sudo pacman -S dosbox doomsday
  ## PlayStation
  sudo pacman -S duckstation-git pcsx2 rpcs3-git
  ## Other consoles (genesis, neko-project
  sudo pacman -S gens-gs xnp2 assimp
  ## Virtual box
  sudo pacman -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle
fi

# IDE from aur
paru -S goland goland-jre pycharm-community pycharm-community-jre

# Set up user groups:
echo "⌛... Adding user to a necessary groups... 👥"
sudo usermod -aG input "$USER"
sudo usermod -aG docker "$USER"
sudo usermod -aG plugdev "$USER"
sudo usermod -aG vboxusers "$USER"
sudo usermod -aG lp "$USER" # bluetooth

# Not aur tools:
go install github.com/masakichi/tango@latest
echo "NOTE: 📚 Import japanese dictionaries with: tango -import ..."

echo "🔥Installation complete!🔥"