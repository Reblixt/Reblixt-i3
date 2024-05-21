#!/usr/bin/env bash

# Install fonts

cd git
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
chmod +x install.sh
./install.sh
