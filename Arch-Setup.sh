#!/usr/bin/env bash

# set -e          # Exit immediately if a command exits with a non-zero status
# set -u          # Treat unset variables as an error and exit immediately
# set -o pipefail # Prevent errors in a pipeline from being masked

# Prompt for Git configuration details
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email
read -p "Do you have SDDM installed? (y/n): " sddm_installed
read -p "Do you have a Nvidia GPU? (y/n): " nvidia_gpu
read -p "Do you hyperland installed? (y/n)" hyperland

echo "Updating and upgrading system packages"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm linux-headers linux-firmware

echo "Installing nvidia drivers"
if [[ "$nvidia_gpu" == "y" ]]; then
	sudo pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings
else
	"Skipping Nvidia drivers installation"
fi

echo "Installing i3 and other packages"
sudo pacman -S --noconfirm i3 thunar picom polybar rofi feh dunst cmus redshift timeshift grub-btrfs starship


echo "For rust relatied packages"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo pacman -S --noconfirm lldb
echo "Installing Bluetooth packages"
sudo pacman -S --noconfirm git bluez bluez-utils blueman

echo "Installing Neovim and other packages"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
sudo pacman -S --noconfirm  neovim fd ripgrep fzf bat btop luarocks wl-clipboard unzip
sudo pacman -S --noconfirm zsh lazygit kitty xclip tmux zoxide glow lsd
sudo npm install -g neovim
nvm install 22

echo "Installing Flatpak"
sudo pacman -S --noconfirm flatpak

echo "Installing Display packages"
sudo pacman -S --noconfirm xorg-xrandr nvidia-settings nvidia-utils

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
yay -S --noconfirm autotiling chromium spotify discord blueberry slack-desktop ttf-symbola noto-fonts-cjk noto-fonts-emoji ttf-twemoji telegram-desktop zen-browser-bin flameshot ghostty-git

echo "Installing Posting"
curl -LsSf https://astral.sh/uv/install.sh | sh

if [[ $hyperland == y ]]; then
  echo "Installing Hyperland"
  yay -S --noconfirm webcord eww wofi hrofi waybar wlsunset hyprshot hyprlock wlogout
  rm -rf ~/.config/eww ~/.config/wofi ~/.config/hrofi ~/.config/waybar
  mv ~/git/Reblixt-i3/config/{eww,wofi,hrofi,waybar,hypr} ~/.config
fi

echo "Moving nfancurve"
mv ~/git/Reblixt-i3/nfancurve-Removethis/ ~/git/nfancurve

echo "Moving Pictures"
mv ~/git/Reblixt-i3/Pictures/ ~/Pictures

echo "Cleaning up old configs"
rm -rf ~/.config/i3 ~/.config/polybar ~/.config/rofi ~/.config/kitty ~/.config/picom.conf 

echo "Moving new configs"
mv ~/git/Reblixt-i3/config/{i3,rofi,polybar,kitty,picom.conf,ghostty,catppuccin,dunst,starship.toml,redshift.conf} ~/.config
chmod +x ~/.config/catppuccin/scripts/cava.sh
chmod +x ~/.config/catppuccin/scripts/cmus.sh
chmod +x ~/.config/catppuccin/scripts/powermenu.sh
chmod +x ~/.config/catppuccin/scripts/launch_polybar.sh
chmod +x ~/.config/catppuccin/scripts/powermenu_fullscreen.sh

echo "Moving zsh config"
mv ~/git/Reblixt-i3/.zshrc ~/

echo "Moving nvim config"
# git clone https://github.com/Reblixt/Solidity-Nvim.git
git clone https://github.com/Reblixt/Nvchad-Neovim.git 
mv Nvchad-Neovim ~/.config/nvim

# git clone https://github.com/Reblixt/NvimChad.git
# mv NvimChad ~/.config/nvim.chad

echo "Making zsh the default shell"
chsh -s $(which zsh)

echo "Config git user and email"
git config --global user.name "$git_username"
git config --global user.email "$git_email"
git config --global core.editor nvim
git config --global init.defaultBranch main

echo "Installing propper fonts and icons"
sudo pacman -S --noconfirm gnu-free-fonts noto-fonts noto-fonts-extra ttf-anonymous-pro ttf-bitstream-vera ttf-caladea ttf-carlito ttf-croscore ttf-dejavu ttf-droid ttf-eurof ttf-fira-code ttf-font-awesome ttf-hack ttf-ibm-plex ttf-inconsolata ttf-indic-otf  ttf-lato ttf-liberation ttf-monofur ttf-nerd-fonts-symbols ttf-opensans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family


echo "Moving Tmux config"
mv ~/git/Reblixt-i3/.tmux ~/
mv ~/git/Reblixt-i3/.tmux.conf ~/

# if [[ "$hyperland" == "y" ]]; then
#   echo "Installing Hyperland"
#   git clone
#   yay -S webcord

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

echo "installing Ufw ---Firewall---"
sudo pacman -S --noconfirm ufw
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
