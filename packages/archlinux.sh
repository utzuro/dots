# !usr/bin/env bash
# TODO: ask user for this parameters
USER=$1
ESSID=$2
PSK=$3

# After first login (with sudo)

wpa_passphrase $ESSID $PSK > /etc/wpa_supplicant.conf
systemctl restart wpa_supplicant.service
# To use netctl instead:
# wifi-menu --> systemctl enable netctl-auto@wlan0 (check name with 'ip link')

timedatectl set-ntp true
useradd -m -G wheel -s /usr/bin/zsh $USER
passwd $USER

# Get essentials:
echo "Setting up xorg, i3 and releated tools..."
pacman -S xorg xorg-xinit i3 xclip xsel xss-lock rofi picom dunst brightnessctl gvim redshift arandr
pacman -S ack sxiv feh imagemagick 
# Apps:
pacman -S firefox chromium vlc gedit kate nautilus stow maim net-tools coreutils konsole asciidoctor xf86-input-libinput 
# Japanese input
pacman -S uim ibus zinnia libmtp ninja clang
# Sound:
pacman -S alsa-lib alsa-plugins alsa-utils pavucontrol pulseaudio pulseaudio-alsa lib32-alsa-plugins lib32-libpulse 
# Graphics:
pacman -S xf86-video-intel mesa lib32-mesa vulkan-intel

# Enable battery manager:
# TODO: Is this laptop?
pacman -S tlp acpi 
systemctl enable --now tlp

# Get bluetooth:
pacman -S bluez bluez-utils bluez-plugins blueman blueberry

# Config touchpad with libinput on x240:
/etc/X11/xorg.conf.d/40-libinput.conf:
Section "InputClass"
    Identifier "libinput clickfinger"
    Driver "libinput"
    Option "ClickMethod" "clickfinger"
    Option "NaturalScrolling" "true"
EndSection

# To get yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Get fonts
yay -S ttf-anonymous-pro ttf-liberation ttf-font-awesome adobe-source-han-sans-jp-fonts otf-ipafont terminus-font bdf-unifont font-bh-ttf ttf-bitstream-vera ttf-dejavu ttf-opensans noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji ttf-ubuntu-font-family ttf-ancient-fonts ttf-font-icons ttf-font-logos otf-ipaexfont otf-ipafont otf-ipamjfont


# Extra Sound:
yay -S pipewire pipewire-pulse pipewire-alsa pipewire-jack lib32-pipewire pulseeffects

# Get gaming and NN:
yay -S nvidia nvidia-utils nvidia-dkms nvidia-xrun nvidia-docker nvidia-docker-compose bbswitch lib32-nvidia-utils lib32-openal lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite gamemode
# Get aur utils: 
yay -S i7z intel-undervolt powertop ntfs-3g bumblebee-status polkit googler ddgr zoxide transfer.sh rofi polybar iotop bind indicator-stickynotes 
# for rofi:
yay -S clerk-git copyq rofi-bluetooth-git rofi-search-git rofi-calc
# for bumblebee:
yay -S xininfo-git ffmpeg xclip maim slop copyq imgurbash2 filebin openssh ix progress
# Convert audiable to mp3
yay -S aaxtomp3 #--authcode 55b7ab34
# Work with Android:
yay -S android-tools simple-mtpfs adbfs-rootless-git 

# Work with Documents
yay -S anki zathura zathura-cb zathura-djvu zathura-pdf-mupdf calibre epub2txt epub2pdf pdf2png sdcv goldendict poppler html2pdf
# Get chats and other
yay -S telegram-desktop telegram-tg-git discord slack-desktop zoom youtube-dl pipe-viewer-git
# Get creative
yay -S simplescreenrecorder-git audio-recorder cplay lmms gimp inkscape krita blender
# Make gui look good:
yay -S qt5ct lxappearance adwaita-qt materia-gtk-theme 
# Get office in need:
yay -S libreoffice-fresh-ja hunspell hunspell-en_US hunspell-uk hunspell-ru libmythes libreoffice-extension-languagetool
# Get emulators:
pacman -S wine-staging winetricks wine-gecko wine-mono
pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox
yay -S docker docker-compose steam dosbox gens-gs duckstation-git pcsx2 rpcs3-git xnp2 assimp doomsday virtualbox virtualbox-guest-iso virtualbox-ext-oracle


# Get unity:
yay -S unityhub mono dotnet-runtime dotnet-sdk rider-eap

# dev
goland goland-jre pycharm-professional 

# Install everything and preconfiged system (light packages)
yay -S base-devel linux linux-headers linux-firmware lvm2  intel-ucode xclip cmake man-db man-pages texinfo gvim git git-lfs tmux openssh sshfs wget mpv mpd ncmpcpp tree unzip unrar htop rsync ranger rtorrent uim ibus zinnia libmtp ninja clang progress firefox chromium vlc gedit kate nautilus redshift sxiv feh arandr imagemagick stow konsole asciidoctor xf86-input-libinput adobe-source-han-sans-jp-fonts ttf-font-awesome ttf-anonymous-pro ntfs-3g clerk-git copyq rofi-search-git rofi-calc android-tools simple-mtpfs adbfs-rootless-git anki zathura zathura-cb zathura-djvu zathura-pdf-mupdf calibre epub2txt epub2pdf pdf2png sdcv goldendict poppler html2pdf telegram-desktop telegram-tg-git discord slack-desktop zoom youtube-dl pipe-viewer-git obs-studio cplay gimp inkscape krita libreoffice-fresh-ja hunspell hunspell-en_US hunspell-uk hunspell-ru libmythes libreoffice-extension-languagetool docker docker-compose steam wine-staging wine-gecko wine-mono winetricks dosbox python-myougiden indicator-stickynotes virtualbox virtualbox-guest-iso virtualbox-ext-oracle i7z intel-undervolt powertop bumblebee-status polkit googler ddgr zoxide transfer.sh rofi polybar iotop bind indicator-stickynotes go php elixir



# Set up user groups:
usermod -aG input $USER
usermod -aG docker $USER
usermod -aG plugdev $USER
usermod -aG vboxusers $USER
usermod -aG lp $USER

# Configure plugins:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Not aur tools:
yay -S python-myougiden
go get github.com/masakichi/tango
tango -import ...
gem install showterm

# fstab example:
# <file system> <dir> <type> <options> <dump> <pass>
UUID=( uuid )       /                   ext4          rw,defaults,noatime,nodiratime   0 1
UUID=( uuid )
UUID=( uuid )       none                swap          defaults         0 0
UUID=( uuid )       /home/$USER/e       ext4          rw,defaults,nofail,noatime,nodiratime,users,exec
UUID=( uuid )       /home/$USER/ntfs    ntfs-3g       rw,noatime,nofail,users,exec,nls=utf8,umask=003,dmask=027,fmask=137,uid=$USER,gid=$USER,windows_names     0 0
