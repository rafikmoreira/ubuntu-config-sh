#!/bin/bash

# This script configure new Ubuntu installation with basic packages and tools for development
# Author: @rafikmoreira

# Update and upgrade Ubuntu packages
sudo apt update && sudo apt upgrade -y

# Install basic packages
sudo apt install -y git curl wget software-properties-common apt-transport-https gcc make gpg g++ build-essential ubuntu-restricted-extras ca-certificates gnupg

# Install my favorite packages
sudo apt install -y vlc inkscape audacity obs-studio libreoffice mailspring lnav

# Install copyq clipboard manager
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
sudo apt install copyq

# install and configure snapd
sudo apt install -y snapd
sudo systemctl enable --now snapd apparmor
sudo snap install core
sudo snap refresh core

# Install snap packages
sudo snap install slack spotify postman insomnia discord skype telegram-desktop kdenlive libreoffice mailspring lnav

# Install ZSH, Oh My ZSH, init zsh and customize
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Change default shell to zsh
sudo chsh -s $(which zsh)
# Install zsh plugins
zsh
# Install zsh themes
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# Install ZInit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
# Install zsh plugins
# --- base ---
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
# --- extras ---
# zinit light zsh-users/zsh-history-substring-search
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-history-search-order
# zinit light zsh-users/zsh-interactive-cd
# zinit light zsh-users/zsh-quickstart-kit
# zinit light zsh-users/zsh-secure-delete
# zinit light zsh-users/zsh-256color
# zinit light zsh-users/zsh-navigation-tools
# zinit light zsh-users/zsh-async

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | zsh
# Configure nvm to load on zsh
echo "source ~/.nvm/nvm.sh" >> ~/.zshrc
# load nvm
source ~/.zshrc
# Install nodejs
nvm install node --lts
# Install yarn
npm install -g yarn
# Install pnpm
npm install -g pnpm

# Install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb -y
rm -f google-chrome*.deb

# Install gvm and go 1.20.5
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ~/.zshrc
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.10
gvm use go1.17.10 --default
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.19.10
gvm use go1.19.10 --default
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.5
gvm use go1.20.5 --default
export GOROOT_BOOTSTRAP=$GOROOT

# Install vscode from Microsoft repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt update
sudo apt install code -y

# Install docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Download and config JetBrains Mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip
mkdir -p ~/.local/share/fonts
mv JetBrainsMono-2.304/ttf/* ~/.local/share/fonts
rm -rf JetBrainsMono-2.304*
fc-cache -f -v

# Download jetbrains toolbox
wget https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-1.28.1.15219.tar.gz
tar -xzf jetbrains-toolbox-1.28.1.15219.tar.gz
rm -f jetbrains-toolbox-1.28.1.15219.tar.gz
sudo chmod +x jetbrains-toolbox-1.28.1.15219/jetbrains-toolbox
./jetbrains-toolbox-1.28.1.15219/jetbrains-toolbox

# Install Java JDK 20
wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb
sudo apt install ./jdk-20_linux-x64_bin.deb -y
rm -f jdk-20_linux-x64_bin.deb

sudo reboot