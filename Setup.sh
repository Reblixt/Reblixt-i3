#!/usr/bin/env bash

set -e          # Exit immediately if a command exits with a non-zero status
set -u          # Treat unset variables as an error and exit immediately
set -o pipefail # Prevent errors in a pipeline from being masked

echo "Updating and upgrading system packages"
sudo pacman -Syu --noconfirm

echo "Installing i3 and other packages"
sudo pacman -S --noconfirm i3 thunar picom polybar rofi feh dunst

echo "Installing Bluetooth packages"
sudo pacman -S --noconfirm git bluez bluez-utils blueman

echo "Installing Neovim and other packages"
sudo pacman -S --noconfirm nodejs npm neovim fd ripgrep fzf bat btop
sudo pacman -S --noconfirm zsh lazygit kitty xclip

echo "Installing Display packages"
sudo pacman -S --noconfirm xorg-xrandr nvidia-settings nvidia-utils

echo "Installing 1Password"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si --noconfirm
cd ..
rm -rf 1password

echo "Enabling Bluetooth service"
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo "Installing packages with yay"
yay -S --noconfirm autotiling brave-bin spotify discord blueberry

echo "Moving nfancurve"
mv ~/git/Reblixt-i3/nfancurve-Removethis/ ~/git/nfancurve

echo "Moving Pictures"
mv ~/git/Reblixt-i3/Pictures/ ~/Pictures

echo "Cleaning up old configs"
rm -rf ~/.config/i3 ~/.config/polybar ~/.config/rofi ~/.config/kitty

echo "Moving new configs"
mv ~/git/Reblixt-i3/config/{i3,rofi,polybar,kitty,picom.conf} ~/.config

echo "Moving zsh config"
mv ~/git/Reblixt-i3/.zshrc ~/

echo "Moving nvim config"
git clone https://github.com/Reblixt/Solidity-Nvim.git
mv Solidity-Nvim ~/.config/nvim

echo "Making zsh the default shell"
chsh -s $(which zsh)

echo "Script completed successfully"
