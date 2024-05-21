# Post-Installation Script for Arch Linux

This script automates the setup and configuration of an Arch Linux system after a fresh installation. It installs essential packages, configures the environment, and sets up various services and tools.

## Prerequisites

Before running the script, make sure you have the following:

- A fresh installation of Arch Linux.
- Internet connectivity.
- `git` installed (you can install it with `sudo pacman -S git` if it's not already installed).

## Usage

1. **Clone the Repository**

   First, clone the repository containing this script to your home directory:

   ```bash
   git https://github.com/Reblixt/Reblixt-i3.git
   cd Reblixt-i3
   chmod +x Setup.sh
   ./Setup.sh
   ```

## What the Script does

1. System update and upgrade

2. Installing these Packages:
   i3, thunar, picom, polybar, rofi, feh, dunst, git, bluez, bluez-utils, blueman, nodejs, npm, neovim, fd, ripgrep, fzf, bat, btop, 1password, yay, brave, chromium spotify discord blueberry zsh, lazygit, kitty, xclip, flatpak, xorg-xrandr, nvidia-settings, nvidia-utils, and ufw.

3. Moving config files for these application:
   nfancurve, Wallpapper, polybar, rofi, picom, kitty, .zshrc, nvim

4. make zsh default shell

5. Setup global git user name, email and default editor

6. configures UFW firewall
