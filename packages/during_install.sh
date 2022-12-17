#!usr/bin/env bash

USER=$1

# Get during install full basic pack:
pacstrap /mnt -S base base-devel linux linux-headers linux-firmware lvm2 sudo intel-ucode man-db man-pages texinfo vim zsh git tmux openssh sshfs wget w3m mpv tree unzip unrar htop rsync ranger mpd ncmpcpp mpc rtorrent ntp grub efibootmgr dosfstools os-prober mtools cmake xsettingsd pasystray xfce4-power-manager dhpcd wpa_supplicant iw iwd 

# if network manager in needed:
pactrap /mnt -S netctl wireless_tools dialog wifi-menu

