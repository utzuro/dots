# ArchLinux notes

This guide strives to help me remember everything that is needed to install Archlinux from the scratch, on laptop, with UEFI and encrypted disk and hibernation.

## Installer USB

### Burn ISO to the memory stick.
```bash
dd if=archlinux.iso of=/dev/sdx bs=4M status=progress oflag=sync
```
> If it won’t boot, you might need to disable Secure Boot in your motherboard settings.

## Installation

### Connect to Wi-Fi if necessary.
```bash
wifi-menu
```
### Make sure system clock is accurate.
```bash
timedatectl set-ntp true
```

### Partition disk. 
#### Create EFI partition first
```bash
fdisk /dev/sdx
Command: n <-- create new partition
Partition number: (default)
First sector: (default)
Last sector: +256M

Command: t
Partition type: 1 # EFI System
```

### Partition disk. 
#### Create main partition
```bash
Command: n
Partition number: (default)
First sector: (default)
Last sector: (default)
```

#### Save changes
```bash
Command: w
```

### Make filesystems
#### Make fat partition for UEFI
```bash
mkfs.fat -F32 /dev/sdx1
```

#### Make main partition encrypted
```bash
cryptsetup luksFormat /dev/sdx2
cryptsetup luksOpen /dev/sdx2 luks
pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks
lvcreate -L 8G vg0 --name swap
lvcreate -l 100%FREE vg0 --name root
mkfs.ext4 /dev/vg0/root
mkswap /dev/vg0/swap
```

### Mount partitions.
```bash
mount /dev/vg0/root /mnt
swapon /dev/vg0/swap
mkdir /mnt/boot
mount /dev/sdx1 /mnt/boot
```

### Install the base system together will necessary packages.

#### Get during install full basic essential pack:
```bash
pacstrap /mnt -S base base-devel linux linux-headers linux-firmware lvm2 sudo intel-ucode man-db man-pages texinfo vim zsh git tmux openssh sshfs wget w3m mpv tree unzip unrar htop rsync ranger mpd ncmpcpp mpc rtorrent ntp grub efibootmgr dosfstools os-prober mtools cmake xsettingsd pasystray xfce4-power-manager
```

#### if network manager in need:
```bash
pactrap /mnt -S netctl wireless_tools dialog dhpcd wpa_supplicant iw iwd 
```

> efibootmgr is necessary for GRUB to add the EFI boot entry, lvm2 for being able to mount LVM devices (here, root partition), dialog and netctl for the wifi-menu command, wpa_supplicant for WPA, and dhcpcd to enable DHCP.

#### Generate /etc/fstab.
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

```bash
vim /mnt/etc/fstab
# Change relatime to noatime on the root partition to reduce SSD wear.
# Add tmpfs /tmp tmpfs rw,noatime,nodev,nosuid 0 0 if you want to keep /tmp in RAM.
```

### `chroot` in the system.

```bash
arch-chroot /mnt
```

### Setup the timezone and synchronize hardware clock.
```bash
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc
# Uncomment the locale you desire in /etc/locale.gen (en_CA.UTF-8 for me, as well as en_GB.UTF-8 to have 24-hour clock format).
locale-gen
echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf
echo 'LC_TIME=ja_JP.UTF-8' >> /etc/locale.conf
```

### Set the hostname.
```bash
echo myhostname > /etc/hostname
```

### Edit /etc/mkinitcpio.conf
> Add encrypt and lvm2 to HOOKS before filesystems. Also add resume after filesystems to support resuming from hibernation.
```bash
# Before
HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)
# After
HOOKS=(base udev autodetect modconf block encrypt lvm2 filesystems resume keyboard fsck)
mkinitcpio -P
```

### Setup the root password.
```bash
passwd
```

### Edit /etc/default/grub 
> Configure the encrypted disk by adding cryptdevice=/dev/sdx2:luks:allow-discards (again, replace /dev/sdx with the proper drive) to GRUB_CMDLINE_LINUX. I also added resume=/dev/vg0/swap for supporting hibernation (resuming from swap).

```bash
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdx2:luks:allow-discards resume=/dev/vg0/swap"
```

### Install GRUB and generate its configuration. 
> Since EFI and boot partition are shared, need to tell GRUB that the EFI directory is /boot.
> On my latest installation (not sure if because new version of software or because different hardware), I also had to add the --bootloader-id option otherwise the system was just unable to boot, while I never had any issue without it before on UEFI systems.
> I’ve also seen systems where grub-install wouldn’t be able to add a boot entry and it needed to be manually added from the motherboard settings (e.g. selecting partition and path to grubx64.efi).
```bash
grub-install --bootloader-id=Arch --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
```

### Exit from chroot, teardown and reboot.
```bash
exit
umount -R /mnt
swapoff -a
reboot
```

## Post installation
### Connect to wifi
```bash
# If nectct in use
wifi-menu
systemctl enable netctl-auto@wlan0 (check name with 'ip link')

# Without nectcl
wpa_passphrase ESSID PSK > /etc/wpa_supplicant.conf
systemctl restart wpa_supplicant.service
## or
wpa_supplicant -B -i wlan -c <(wpa_passphrase ESSID PSK)
## or 
sudo iwconfig wlan ESSID s:PSK
```

# Config touchpad with libinput on x240:
#/etc/X11/xorg.conf.d/40-libinput.conf:
#Section "InputClass"
#        Identifier "libinput clickfinger"
#        Driver "libinput"
#        Option "ClickMethod" "clickfinger"
#        Option "NaturalScrolling" "true"
#EndSection

# fstab example:
# <file system> <dir> <type> <options> <dump> <pass>
UUID=( uuid )       /                   ext4          rw,defaults,noatime,nodiratime   0 1
UUID=( uuid )
UUID=( uuid )       none                swap          defaults         0 0
UUID=( uuid )       /home/"$USER"/e       ext4          rw,defaults,nofail,noatime,nodiratime,users,exec
UUID=( uuid )       /home/"$USER"/ntfs    ntfs-3g       rw,noatime,nofail,users,exec,nls=utf8,umask=003,dmask=027,fmask=137,uid="$USER",gid=""$USER"",windows_names     0 0



timedatectl set-ntp true
useradd -m -G wheel -s /usr/bin/zsh $USER
passwd $USER
Enable time synchronization.

timedatectl set-ntp true
Add user and set password.

useradd -m -G wheel -s /usr/bin/zsh val
passwd val
Install the packages you need. Here’s my personal selection.

tlp for out of the box power management
xf86-video-intel graphics driver
xorg-server
xorg-xset as I use it in my .xinitrc for setting key repeat delay
xorg-xrandr to setup multiple monitors
noto-fonts main system font
noto-fonts-cjk and noto-fonts-extra optionally to really see every character online
noto-fonts-emoji because emojis
ttf-liberation for proper web fonts support
lightdm display manager
lightdm-mini-greeter (from AUR)
i3-gaps window manager
i3lock locker
i3blocks status bar
xfce4-terminal
dmenu
firefox
picom for xfce4-terminal background transparency
alsa-utils for native audio
pulseaudio sound server
pulseaudio-alsa for PulseAudio to control ALSA
pulseaudio-bluetooth for PulseAudio to control Bluetooth devices
pavucontrol for an audio GUI
bluez for Bluetooth support
blueberry for a Bluetooth GUI
feh image viewer and background setter
maim and imagemagick as my custom i3locks locker depends on them
xsel, xclip for clipboard management
xorg-xbacklight or light for changing screen brightness (my experience is that depending on the laptop, one of them will work and the other one won’t)
acpi to get battery information (the i3blocks battery blocklet depends on it)
openssh
redshift, started in my .xinitrc, to adjust screen color temperature based on time of day
jq as my script to preserve working directory when opening a new terminal depends on it
xss-lock, started in my .xinitrc, auto lock on screen sleep, suspend and hibernate
zip, unzip
ack
For some reason PulseAudio might require a reboot to work.

¶TLP
systemctl enable tlp
systemctl start tlp
¶LightDM
In /etc/lightdm/lightdm.conf, set greeter-session=lightdm-mini-greeter or whatever is the greeter of your choice.

If using lightdm-mini-greeter, modify /etc/lightdm/lightdm-mini-greeter.conf to set the user.

I use LightDM so that my X session is started as a logind GUI session as opposed to being considered to be a TTY if I would use xinit. This allows something like xss-lock to report idle status to logind so that logind can properly run the configured IdleAction.

I usually set IdleAction=suspend in /etc/systemd/logind.conf so that my system suspends after 30 minutes of inactivity.

It seems there’s no way to upgrade a logind TTY session to a graphical session so that it would allow to report the idle hint, and since for a TTY session the idle status doesn’t use the idle hint but uses the last TTY input instead, it is always considered to be idled if a X session is started with xinit or startx, which is why I resorted to use a display manager.

¶Bluetooth
Enable Bluetooth.

systemctl enable bluetooth
systemctl start bluetooth
In practice I usually don’t enable Bluetooth and I systemctl start bluetooth and systemctl stop bluetooth as I need it.

¶Touchpad
I add the following to /etc/X11/xorg.conf.d/40-libinput.conf to have the touchpad work the way I like it to (natural scrolling and having the whole surface clickable).

Section "InputClass"
        Identifier "libinput clickfinger"
        Driver "libinput"
        Option "ClickMethod" "clickfinger"
        Option "NaturalScrolling" "true"
EndSection
¶Auto hibernate after sustained suspend
If you want to have the system hibernate after being suspended for some time (3 hours by default as per /etc/systemd/sleep.conf HibernateDelaySec), run the following:

ln -s /usr/lib/systemd/system/systemd-suspend-then-hibernate.service /etc/systemd/system/systemd-suspend.service
The advantage of this solution is anything that would normally just suspend will suspend then hibernate, which is an easy way to make sure that in any case the system will hibernate if suspended for more than 3 hours to save battery.

Hack from this Reddit thread.

¶DisplayLink adapter for multiple monitors and Ethernet
On my work laptop, installing displaylink and evdi from the AUR just worked out of the box.

¶Final touch
After logging in with my regular user, I finish the configuration by cloning and installing my dotfiles.

git clone https://github.com/valeriangalliat/dotfiles.git
cd dotfiles
make i3 i3blocks zsh vim git net x11 picom xfce4-terminal
Lastly, in Firefox I add the Vimium-FF and uBlock Origin extensions.

And here you go, a somewhat minimalist Arch Linux setup with everything needed to have a smooth laptop experience!

Generated from a public repository. Pull requests and issues are welcome!



LENOVO LEGION Y530:
My *working* Nvidia Optimus setup (and more) for Lenovo Legion Y530

Because some of you have been asking a few questions in my previous thread, I thought I will share everything I need to make my Optimus setup (aand a few more things on this laptop) to work. I may make a Wiki page too for the Device, but that might never happen due to my laziness, so people will be able to find it here at the least. I dont do way too specific stuff so that you go to the Arch Wiki and look stuff up yourself, but feel free to ask if needed:

    intel UHD 630, GTX 1050 ti

    nvidia-xrun, bbswitch(-drm for custom kernel), nvidia(-drm) newest driver

    blacklist nvidia-drm, nvidia-modeset and nvidia in /etc/modprobe.d

    bbswitch started in /etc/modules-load.d/bbswitch, and keeps Nvidia card turned off at boot due to settings in /etc/modprobe.d/bbswitch.conf. bbswitch

    startx to intel only start, nvidia-xrun to nvidia+intel with full graphics utilization, dont start both because intel cant run separately Nvidia needs it (maybe only for PRIME sync?). nvidia-xrun, including more info on bbswitch

    Grub boot has nvidia-drm.modeset=1 to enable PRIME sync to be tearfree on laptop Screen when using Nvidia. No you dont need to add nvidia modules to initramfs modules contrary to the wiki. nvidia-drm-kms

    I have to do this to avoid tearing on connected monitors. github issue at nvidia-xrun

    I have to use the "Tearfree" option for intel-only in Xorg to avoid tearing, OR just use compton for it might not hurt performance that much. Also it starts with initramfs.intel tearing

Watch out:

    Wine Gallium nine patches wont work, they are not supported on intel and proprietary nvidia drivers.

Laptop-specific stuff:

rtl8822be wireless card:

    It both has Bluetooth and WIFI. aspm (power saving) needs to be turned off due to the driver being pretty premature (its in staging branch), thus throws the card to an off state without being able to turn up its interface ever again. random ubuntu user thread about this problem. tl;dr "echo "options r8822be aspm=0" > /etc/modprobe/r8822be.conf"

    rfkill blocks the card (so no internet unless you unblock with "rfkill" command) due to the "ideapad_laptop" module, thus you need to disable it to have internet+bluetooth from the get go. "echo "blacklist ideapad_laptop" >> /etc/modprobe.d/blacklist.conf".

acpi (barely looked into automatic handling with spec keys):

    You can turn brightness from the get go with "echo "<value>" > /sys/class/backlight/intel_backlight/brightness". Read actual brightness from "actual_brightness", max from "max_brightness".

    You can see battery info from the getgo with "cat /sys/class/power_supply/BAT0/uevent". POWER_SUPPLY_CAPACITY should suffice. Other than that, with the "acpi" command.

UEFI:

    It may randomly delete, reorder, remove entries from bootorder. "UEFI mode" instead of legacy seems to be stable in that matter at this point, but you may have to learn making entries with efibootmgr to bring back your install from time to time.

optimisation:

    powertop: intel powersaving tool. Use the "--auto-tune" flag to turn on every available powersaving stuff. I did not see any downsides as of date. Mouse might get suspended after not using it for a few seconds

    intel-undervolt -160mV on CPU and CPU cache (though be aware for it might be too low for some, or the performance might suffer). I also dont see it throttling anymore, especially after powertop --auto-tune also ran.

    cpu-power: for setting CPU governors and frequency and perf-bias. performance governor keeps frequency near 3-4Ghz (but not under load, so it wont heat) that makes Voltage being kept high. So powersaving is advised at all times when no battery is at hand.

    i7z: intel utility for constant CPU info on... everything.

    sensors (lm_sensors package): to see temperature.

watch out:

    If the laptop wont power off, it is either that you have USB (maybe other ports too) devices plugged in (really, it turned off after it detected that I pulled all my devices) or it has problems with modules (most likely r8822be. If something is not okay in that regard, it will most likely hang indefinitely). (though I might be wrong on this one)
