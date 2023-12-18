# Reblixt-i3

## to enable bluetooth run

sudo pacman -S --needed bluez bluez-utils blueman
sudo systemctl enable --now bluetooth

## Nvidia driver install

sudo pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings xorg-server-devel

## install nfancurve

mkdir git
cd git
git clone https://github.com/nan0s7/nfancurve.git
cd nfancurve
chmod +x temp.sh
