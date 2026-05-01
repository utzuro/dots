#!/usr/bin/env bash
set -e

USER=$1

# --- Install base system packages ---
pacstrap /mnt -S base base-devel linux linux-headers linux-firmware lvm2 sudo intel-ucode man-db man-pages texinfo vim zsh git tmux openssh sshfs wget w3m mpv tree unzip unrar htop rsync ranger mpd ncmpcpp mpc rtorrent ntp grub efibootmgr dosfstools os-prober mtools cmake xsettingsd pasystray xfce4-power-manager dhcpcd wpa_supplicant iw iwd

# --- Install network tools ---
pacstrap /mnt -S netctl wireless_tools dialog wifi-menu
