#!/usr/bin/env bash

set -e          # Exit immediately if a command exits with a non-zero status
set -u          # Treat unset variables as an error and exit immediately
set -o pipefail # Prevent errors in a pipeline from being masked

# Prompt for Git configuration details
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email
read -p "Do you have SDDM installed? (y/n): " sddm_installed
read -p "Do you have a Nvidia GPU? (y/n): " nvidia_gpu

echo "Updating and upgrading system packages"
sudo apt update && sudo apt upgrade -y
#sudo apt install -y linux-headers-$(uname -r) linux-firmware

# echo "Installing nvidia drivers"
# if [[ "$nvidia_gpu" == "y" ]]; then
#   sudo apt install -y nvidia-driver-470 nvidia-settings
# else
#   echo "Skipping Nvidia drivers installation"
# fi

echo "Installing i3 and other packages"
sudo apt install -y i3 thunar picom polybar rofi feh dunst cmus nala nala

echo "Installing Bluetooth packages"
sudo apt install -y git bluez bluez-tools blueman

echo "Installing Neovim and other packages"
sudo apt install -y neovim fd-find ripgrep fzf bat btop
sudo apt install -y zsh alacritty xclip tmux zoxide playerctl

echo "Installing Flatpak"
sudo apt install -y flatpak

# echo "Installing Display packages"
# sudo apt install -y x11-xserver-utils nvidia-settings

# echo "Installing 1Password"
# curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
# curl -sS https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb -o 1password.deb
# sudo apt install -y ./1password.deb
# rm 1password.deb

# echo "Enabling Bluetooth service"
# sudo systemctl enable bluetooth.service
# sudo systemctl start bluetooth.service

# echo "Installing Snap"
# sudo apt install -y snapd

# echo "Installing packages with Snap"
# sudo snap install brave
# sudo snap install chromium
# sudo snap install spotify
# sudo snap install discord
#
echo "Moving nfancurve"
mv ~/git/Reblixt-i3/nfancurve-Removethis/ ~/git/nfancurve

echo "Moving Pictures"
mv ~/git/Reblixt-i3/Pictures/ ~/Pictures

echo "Cleaning up old configs"
rm -rf ~/.config/i3 ~/.config/polybar ~/.config/rofi ~/.config/picom.conf ~/.config/alacritty

echo "Moving new configs"
mv ~/git/Reblixt-i3/config/{i3,rofi,polybar,picom.conf,alacritty,catppuccin,dunst} ~/.config
chmod +x ~/.config/catppuccin/scripts/cava.sh
chmod +x ~/.config/catppuccin/scripts/cmus.sh
chmod +x ~/.config/catppuccin/scripts/powermenu.sh
chmod +x ~/.config/catppuccin/scripts/launch_polybar.sh
chmod +x ~/.config/catppuccin/scripts/powermenu_fullscreen.sh

echo "Moving zsh config"
mv ~/git/Reblixt-i3/.zshrc ~/

echo "Moving nvim config"
git clone https://github.com/Reblixt/Solidity-Nvim.git
mv Solidity-Nvim ~/.config/nvim

echo "Making zsh the default shell"
chsh -s $(which zsh)

echo "Config git user and email"
git config --global user.name "$git_username"
git config --global user.email "$git_email"
git config --global core.editor nvim
git config --global init.defaultBranch main

echo "Moving Tmux config"
mv ~/git/Reblixt-i3/.tmux ~/
mv ~/git/Reblixt-i3/.tmux.conf ~/

if [[ "$sddm_installed" == "y" ]]; then
  echo "Configuring SDDM"
  sudo mv ~/git/Reblixt-i3/catppuccin-macchiato /usr/share/sddm/themes/

  # Kontrollera om filen /etc/sddm.conf finns, om inte, skapa den
  if [[ ! -f /etc/sddm.conf ]]; then
    echo "/etc/sddm.conf does not exist. Creating it."
    sudo touch /etc/sddm.conf
  fi
  # Lägg till texten till /etc/sddm.conf
  echo "Adding theme configuration to /etc/sddm.conf"
  echo "[Theme]" | sudo tee -a /etc/sddm.conf
  echo "Current=catppuccin-macchiato" | sudo tee -a /etc/sddm.conf

else
  echo "Skipping SDDM installation"
fi

echo "Installing Ufw ---Firewall---"
sudo apt install -y ufw
sudo ufw enable
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "Script completed successfully"

echo "Rebooting system is recommended to apply changes."
read -p "Reboot now? (y/n): " reboot_now
if [[ "$reboot_now" == "y" ]]; then
  sudo reboot
fi

echo "Please reboot soon to apply changes."
